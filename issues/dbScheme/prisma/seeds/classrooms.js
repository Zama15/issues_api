export async function seedClassroomTypes(prisma) {
  const [lectureType, labType, auditoriumType] = await Promise.all([
    prisma.classroom_Types.create({
      data: {
        sNameClassroomTypes: "LECTURE",
        bStateClassroomTypes: true,
      },
    }),
    prisma.classroom_Types.create({
      data: {
        sNameClassroomTypes: "LAB",
        bStateClassroomTypes: true,
      },
    }),
    prisma.classroom_Types.create({
      data: {
        sNameClassroomTypes: "AUDITORIUM",
        bStateClassroomTypes: true,
      },
    }),
  ]);

  return {
    lectureType,
    labType,
    auditoriumType,
  };
}

export async function seedClassrooms(prisma, classroomTypes, grades, groups) {
  const { lectureType, labType } = classroomTypes;
  const { grade1, grade2 } = grades;
  const { groupA, groupB } = groups;

  const class101 = await prisma.classrooms.create({
    data: {
      sNameClassrooms: "Room 101",
      bStateClassrooms: true,
      fkIdClassroomTypes: lectureType.iIdClassroomTypes,
      fkIdGrades: grade1.iIdGrades,
      fkIdGroups: groupA.iIdGroups,
    },
  });

  const lab201 = await prisma.classrooms.create({
    data: {
      sNameClassrooms: "Lab 201",
      bStateClassrooms: true,
      fkIdClassroomTypes: labType.iIdClassroomTypes,
      fkIdGrades: grade2.iIdGrades,
      fkIdGroups: groupB.iIdGroups,
    },
  });

  return {
    class101,
    lab201,
  };
}
