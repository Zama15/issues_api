import { PrismaClient } from "@prisma/client";
import { faker } from "@faker-js/faker";

export async function seedCatalog(prisma: PrismaClient) {
  console.log("Seeding catalog data...");

  await prisma.publisher.createMany({
    data: Array.from({ length: 15 }, () => ({
      name: faker.company.name(),
      address: faker.location.streetAddress(true),
    })),
  });
  const publishers = await prisma.publisher.findMany({
    orderBy: { createdAt: "asc" },
  });

  await prisma.author.createMany({
    data: Array.from({ length: 50 }, () => ({
      firstName: faker.person.firstName(),
      lastName: faker.person.lastName(),
      birthDate: faker.date.birthdate({ min: 1800, max: 2000, mode: "year" }),
    })),
  });
  const authors = await prisma.author.findMany({
    orderBy: { createdAt: "asc" },
  });

  await prisma.subject.createMany({
    data: Array.from({ length: 20 }, () => ({
      name: faker.word.noun({ length: { min: 5, max: 10 } }),
    })),
  });
  const subjects = await prisma.subject.findMany({
    orderBy: { createdAt: "asc" },
  });

  await prisma.series.createMany({
    data: Array.from({ length: 10 }, () => ({
      name: `${faker.word.adjective()} Chronicles`,
    })),
  });
  const series = await prisma.series.findMany({
    orderBy: { createdAt: "asc" },
  });

  console.log("Catalog data seeded.");
  return { publishers, authors, subjects, series };
}
