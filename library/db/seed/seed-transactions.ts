import { PrismaClient } from '@prisma/client';
import { faker } from '@faker-js/faker';

interface TransactionSeedData {
  itemCopyIds: number[];
  patronIds: number[];
  staffIds: number[];
}

export async function seedTransactions(prisma: PrismaClient, data: TransactionSeedData) {
  console.log('Seeding transactions (loans and fines)...');
  const { itemCopyIds, patronIds, staffIds } = data;

  const onLoanStatusId = (await prisma.copyStatus.findFirst({ where: { name: 'On Loan' } }))!.id;

  // Create some active loans
  for (let i = 0; i < 50; i++) {
    const itemCopyId = faker.helpers.arrayElement(itemCopyIds);
    const patronId = faker.helpers.arrayElement(patronIds);
    const staffId = faker.helpers.arrayElement(staffIds);
    const checkoutDate = faker.date.past({ years: 1 });
    const dueDate = faker.date.future({ refDate: checkoutDate });

    // Ensure we don't try to loan an already loaned copy in this seed run
    const existingLoan = await prisma.loan.findFirst({ where: { itemCopyId, returnDate: null } });
    if (existingLoan) continue;
    
    await prisma.loan.create({
      data: {
        itemCopyId,
        patronId,
        checkoutStaffId: staffId,
        checkoutDate,
        dueDate,
      },
    });

    // Update the copy status
    await prisma.itemCopy.update({
      where: { id: itemCopyId },
      data: { copyStatusId: onLoanStatusId },
    });
  }

  // Create some historic, overdue loans with fines
  for (let i = 0; i < 20; i++) {
    const itemCopyId = faker.helpers.arrayElement(itemCopyIds);
    const patronId = faker.helpers.arrayElement(patronIds);
    const staffId = faker.helpers.arrayElement(staffIds);
    
    // Ensure we don't try to loan an already loaned copy in this seed run
    const existingLoan = await prisma.loan.findFirst({ where: { itemCopyId, returnDate: null } });
    if (existingLoan) continue;
    
    const checkoutDate = faker.date.past({ years: 2 });
    const dueDate = faker.date.soon({ days: 14, refDate: checkoutDate });
    const returnDate = faker.date.soon({ days: 20, refDate: dueDate }); // Returned 20 days late

    const loan = await prisma.loan.create({
        data: {
            itemCopyId,
            patronId,
            checkoutStaffId: staffId,
            checkinStaffId: faker.helpers.arrayElement(staffIds),
            checkoutDate,
            dueDate,
            returnDate,
        },
    });
    
    await prisma.fine.create({
        data: {
            loanId: loan.id,
            patronId,
            amount: faker.finance.amount({min: 5, max: 25}),
            dateIssued: returnDate,
            status: 'Unpaid'
        }
    })
  }

  console.log('Transactions seeded.');
}
