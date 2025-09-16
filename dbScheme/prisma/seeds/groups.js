export async function seedGroups(prisma, careers, tutorUser) {
  const { engCareer, mathCareer } = careers;

  const groupA = await prisma.groups.create({
    data: {
      sNameGroups: "CE-1A",
      bStateGroups: true,
      fkIdCareers: engCareer.iIdCareers,
      fkIdTutor: tutorUser.iIdUsers,
    },
  });

  const groupB = await prisma.groups.create({
    data: {
      sNameGroups: "CE-1B",
      bStateGroups: true,
      fkIdCareers: engCareer.iIdCareers,
      fkIdTutor: tutorUser.iIdUsers,
    },
  });

  const groupC = await prisma.groups.create({
    data: {
      sNameGroups: "MATH-1A",
      bStateGroups: true,
      fkIdCareers: mathCareer.iIdCareers,
      fkIdTutor: tutorUser.iIdUsers,
    },
  });

  return {
    groupA,
    groupB,
    groupC,
  };
}

export async function seedGrades(prisma, groups) {
  const { groupA, groupB, groupC } = groups;

  const grade1 = await prisma.grades.create({
    data: {
      sNameGrades: "First Year",
      bStateGrades: true,
      fkIdGroups: groupA.iIdGroups,
    },
  });

  const grade2 = await prisma.grades.create({
    data: {
      sNameGrades: "Second Year",
      bStateGrades: true,
      fkIdGroups: groupB.iIdGroups,
    },
  });

  const grade3 = await prisma.grades.create({
    data: {
      sNameGrades: "First Year Math",
      bStateGrades: true,
      fkIdGroups: groupC.iIdGroups,
    },
  });

  return {
    grade1,
    grade2,
    grade3,
  };
}
