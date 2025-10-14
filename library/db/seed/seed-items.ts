import { PrismaClient } from "@prisma/client";
import { faker } from "@faker-js/faker";

interface ItemSeedData {
  publisherIds: number[];
  authorIds: number[];
  subjectIds: number[];
  seriesIds: number[];
  itemTypeIds: number[];
  languageIds: number[];
  copyStatusIds: number[];
}

export async function seedItems(prisma: PrismaClient, data: ItemSeedData) {
  console.log("Seeding items, copies, and relations...");
  const {
    publisherIds,
    authorIds,
    subjectIds,
    seriesIds,
    itemTypeIds,
    languageIds,
    copyStatusIds,
  } = data;

  const availableStatusId = (await prisma.copyStatus.findFirst({
    where: { name: "Available" },
  }))!.id;
  const ebookTypeId = (await prisma.itemType.findFirst({
    where: { name: "E-book" },
  }))!.id;

  const items = [];
  for (let i = 0; i < 200; i++) {
    const uniqueAuthorIds = faker.helpers
      .shuffle(authorIds)
      .slice(0, faker.number.int({ min: 1, max: 2 }));
    const uniqueSubjectIds = faker.helpers
      .shuffle(subjectIds)
      .slice(0, faker.number.int({ min: 1, max: 3 }));

    const item = await prisma.item.create({
      data: {
        title: faker.lorem.words(3).replace(/\b\w/g, (l) => l.toUpperCase()),
        publisherId: faker.helpers.arrayElement(publisherIds),
        publicationDate: faker.date.past({ years: 20 }).getFullYear(),
        isbn: faker.commerce.isbn({ variant: 13, separator: "" }),
        itemTypeId: faker.helpers.arrayElement(itemTypeIds),
        seriesId: faker.helpers.maybe(
          () => faker.helpers.arrayElement(seriesIds),
          { probability: 0.2 }
        ),
        languageId: faker.helpers.arrayElement(languageIds),
        description: faker.lorem.paragraph(),

        itemAuthors: {
          create: uniqueAuthorIds.map((id) => ({
            authorId: id,
          })),
        },
        itemSubjects: {
          create: uniqueSubjectIds.map((id) => ({
            subjectId: id,
          })),
        },
      },
    });
    items.push(item);
  }

  const itemCopies = [];
  const digitalResources = [];

  for (const item of items) {
    if (item.itemTypeId === ebookTypeId) {
      // Create a digital resource for e-books
      const resource = await prisma.digitalResource.create({
        data: {
          itemId: item.id,
          viewUrl: faker.internet.url(),
          isDownloadable: faker.datatype.boolean(),
          fileFormat: "EPUB",
        },
      });
      digitalResources.push(resource);
    } else {
      // Create physical copies for other types
      const copiesToCreate = faker.number.int({ min: 1, max: 5 });
      for (let i = 0; i < copiesToCreate; i++) {
        const copy = await prisma.itemCopy.create({
          data: {
            itemId: item.id,
            barcode: faker.string.alphanumeric(12).toUpperCase(),
            copyStatusId: availableStatusId,
            purchasePrice: faker.commerce.price({ min: 10, max: 100 }),
          },
        });
        itemCopies.push(copy);
      }
    }
  }

  console.log("Items seeded.");
  return { items, itemCopies, digitalResources };
}
