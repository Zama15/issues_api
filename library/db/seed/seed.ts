import { PrismaClient } from "@prisma/client";
import { seedStaticData } from "./seed-static";
import { seedCatalog } from "./seed-catalog";
import { seedPeople } from "./seed-people";
import { seedItems } from "./seed-items";
import { seedTransactions } from "./seed-transactions";

const prisma = new PrismaClient();

async function main() {
  console.log(`Start seeding ...`);

  // ---------------------------------------------------------------------------
  // >> CLEANUP: Delete in reverse order of creation to respect FK constraints
  // ---------------------------------------------------------------------------
  console.log("Cleaning up existing data...");
  // Actions
  await prisma.payment.deleteMany();
  await prisma.fine.deleteMany();
  await prisma.loan.deleteMany();
  await prisma.reservation.deleteMany();
  // People
  await prisma.staff.deleteMany();
  await prisma.patron.deleteMany();
  // Items & Junctions
  await prisma.itemAuthor.deleteMany();
  await prisma.itemSubject.deleteMany();
  await prisma.digitalResource.deleteMany();
  await prisma.itemCopy.deleteMany();
  await prisma.item.deleteMany();
  // Catalog & Support
  await prisma.author.deleteMany();
  await prisma.publisher.deleteMany();
  await prisma.subject.deleteMany();
  await prisma.series.deleteMany();
  await prisma.staffRolePermission.deleteMany();
  await prisma.permission.deleteMany();
  await prisma.staffRole.deleteMany();
  await prisma.patronAccountStatus.deleteMany();
  await prisma.patronType.deleteMany();
  await prisma.copyStatus.deleteMany();
  await prisma.itemType.deleteMany();
  await prisma.language.deleteMany();
  // Location
  await prisma.department.deleteMany();
  await prisma.libraryBranch.deleteMany();
  console.log("Cleanup complete.");

  // ---------------------------------------------------------------------------
  // >> SEEDING: Seed in order of dependency
  // ---------------------------------------------------------------------------

  // 1. Seed static, non-relational lookup data first
  const staticData = await seedStaticData(prisma);

  // 2. Seed core catalog entities
  const catalogData = await seedCatalog(prisma);

  // 3. Seed patrons and staff
  const peopleData = await seedPeople(prisma, {
    patronTypeIds: staticData.patronTypes.map((pt) => pt.id),
    patronAccountStatusIds: staticData.patronAccountStatuses.map((ps) => ps.id),
    staffRoleIds: staticData.staffRoles.map((sr) => sr.id),
  });

  // 4. Seed the main items, copies, and their relations to the catalog
  const itemData = await seedItems(prisma, {
    publisherIds: catalogData.publishers.map((p) => p.id),
    authorIds: catalogData.authors.map((a) => a.id),
    subjectIds: catalogData.subjects.map((s) => s.id),
    seriesIds: catalogData.series.map((s) => s.id),
    itemTypeIds: staticData.itemTypes.map((it) => it.id),
    languageIds: staticData.languages.map((l) => l.id),
    copyStatusIds: staticData.copyStatuses.map((cs) => cs.id),
  });

  // 5. Seed transactions to simulate library activity
  await seedTransactions(prisma, {
    itemCopyIds: itemData.itemCopies.map((ic) => ic.id),
    patronIds: peopleData.patrons.map((p) => p.id),
    staffIds: peopleData.staff.map((s) => s.id),
  });

  console.log(`Seeding finished.`);
}

main()
  .catch(async (e) => {
    console.error(e);
    await prisma.$disconnect();
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
