import { PrismaClient } from "@prisma/client";
import { faker } from "@faker-js/faker";

interface PeopleSeedData {
  patronTypeIds: number[];
  patronAccountStatusIds: number[];
  staffRoleIds: number[];
}

export async function seedPeople(prisma: PrismaClient, data: PeopleSeedData) {
  console.log("Seeding people (patrons and staff)...");
  const { patronTypeIds, patronAccountStatusIds, staffRoleIds } = data;

  const activeStatusId = (await prisma.patronAccountStatus.findFirst({
    where: { name: "Active" },
  }))!.id;

  await prisma.patron.createMany({
    data: Array.from({ length: 100 }, (_, i) => ({
      universityId: parseInt(`2024${String(i + 1).padStart(4, "0")}`),
      firstName: faker.person.firstName(),
      lastName: faker.person.lastName(),
      email: faker.internet.email({ allowSpecialCharacters: false }),
      patronTypeId: faker.helpers.arrayElement(patronTypeIds),
      patronAccountStatusId: activeStatusId,
      registrationDate: faker.date.past({ years: 4 }),
    })),
  });
  const patrons = await prisma.patron.findMany({
    orderBy: { createdAt: "asc" },
  });

  await prisma.staff.createMany({
    data: Array.from({ length: 20 }, (_, i) => ({
      universityId: i + 1001,
      firstName: faker.person.firstName(),
      lastName: faker.person.lastName(),
      email: faker.internet.email({
        firstName: "staff",
        allowSpecialCharacters: false,
      }),
      staffRoleId: faker.helpers.arrayElement(staffRoleIds),
    })),
  });
  const staff = await prisma.staff.findMany({
    orderBy: { createdAt: "asc" },
  });

  console.log("People seeded.");
  return { patrons, staff };
}
