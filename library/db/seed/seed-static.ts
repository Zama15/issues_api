import { PrismaClient } from "@prisma/client";

export async function seedStaticData(prisma: PrismaClient) {
  console.log("Seeding static lookup data...");

  await prisma.patronType.createMany({
    data: [
      { name: "Undergraduate", loanLimit: 10, loanDurationDays: 14 },
      { name: "Graduate", loanLimit: 20, loanDurationDays: 30 },
      { name: "Faculty", loanLimit: 50, loanDurationDays: 120 },
      { name: "Staff", loanLimit: 15, loanDurationDays: 21 },
    ],
  });
  const patronTypes = await prisma.patronType.findMany({
    orderBy: { createdAt: "asc" },
  });

  await prisma.patronAccountStatus.createMany({
    data: [
      { name: "Active" },
      { name: "Suspended - Fines Due" },
      { name: "Expired" },
    ],
  });
  const patronAccountStatuses = await prisma.patronAccountStatus.findMany({
    orderBy: { createdAt: "asc" },
  });

  await prisma.copyStatus.createMany({
    data: [
      { name: "Available" },
      { name: "On Loan" },
      { name: "On Reserve" },
      { name: "In Repair" },
      { name: "Lost" },
    ],
  });
  const copyStatuses = await prisma.copyStatus.findMany({
    orderBy: { createdAt: "asc" },
  });

  await prisma.itemType.createMany({
    data: [
      { name: "Book" },
      { name: "Journal" },
      { name: "E-book" },
      { name: "Thesis" },
      { name: "DVD" },
    ],
  });
  const itemTypes = await prisma.itemType.findMany({
    orderBy: { createdAt: "asc" },
  });

  await prisma.staffRole.createMany({
    data: [
      { name: "Librarian" },
      { name: "System Administrator" },
      { name: "Student Worker" },
      { name: "Archivist" },
    ],
  });
  const staffRoles = await prisma.staffRole.findMany({
    orderBy: { createdAt: "asc" },
  });

  await prisma.permission.createMany({
    data: [
      { name: "CAN_PROCESS_LOANS", description: "Can check items in and out." },
      {
        name: "CAN_WAIVE_FINES",
        description: "Can waive outstanding fines for patrons.",
      },
      {
        name: "MANAGE_PATRONS",
        description: "Can create, edit, and delete patron accounts.",
      },
      {
        name: "MANAGE_CATALOG",
        description: "Can add, edit, and delete items from the catalog.",
      },
      {
        name: "SYSTEM_ADMIN_ACCESS",
        description: "Full access to all system settings.",
      },
    ],
  });
  const permissions = await prisma.permission.findMany({
    orderBy: { createdAt: "asc" },
  });

  // Assign permissions to roles
  const librarianRole = staffRoles.find((r) => r.name === "Librarian")!;
  const adminRole = staffRoles.find((r) => r.name === "System Administrator")!;

  await prisma.staffRolePermission.createMany({
    data: [
      // Librarian permissions
      {
        staffRoleId: librarianRole.id,
        permissionId: permissions.find((p) => p.name === "CAN_PROCESS_LOANS")!
          .id,
      },
      {
        staffRoleId: librarianRole.id,
        permissionId: permissions.find((p) => p.name === "CAN_WAIVE_FINES")!.id,
      },
      {
        staffRoleId: librarianRole.id,
        permissionId: permissions.find((p) => p.name === "MANAGE_PATRONS")!.id,
      },
      // Admin gets all permissions
      ...permissions.map((p) => ({
        staffRoleId: adminRole.id,
        permissionId: p.id,
      })),
    ],
  });

  await prisma.language.createMany({
    data: [
      { name: "English", isoCode: "eng" },
      { name: "Spanish", isoCode: "spa" },
      { name: "French", isoCode: "fre" },
      { name: "German", isoCode: "ger" },
    ],
  });
  const languages = await prisma.language.findMany({
    orderBy: { createdAt: "asc" },
  });

  await prisma.libraryBranch.create({
    data: { name: "John F. Kennedy Memorial Library" },
  });
  await prisma.department.create({ data: { name: "Computer Science" } });

  console.log("Static data seeded.");
  return {
    patronTypes,
    patronAccountStatuses,
    copyStatuses,
    itemTypes,
    staffRoles,
    permissions,
    languages,
  };
}
