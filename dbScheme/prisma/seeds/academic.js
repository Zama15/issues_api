export async function seedFaculties(prisma) {
  const engineeringFaculty = await prisma.faculties.create({
    data: {
      sNameFaculties: "Engineering Faculty",
      bStateFaculties: true,
    },
  });

  const scienceFaculty = await prisma.faculties.create({
    data: {
      sNameFaculties: "Science Faculty",
      bStateFaculties: true,
    },
  });

  return {
    engineeringFaculty,
    scienceFaculty,
  };
}

export async function seedCareers(prisma, tutorUser, faculties) {
  const { engineeringFaculty, scienceFaculty } = faculties;

  const engCareer = await prisma.careers.create({
    data: {
      sNameCareers: "Computer Engineering",
      bStateCareers: true,
      fkIdCareerCoord: tutorUser.iIdUsers,
      fkIdFaculties: engineeringFaculty.iIdFaculties,
    },
  });

  const mathCareer = await prisma.careers.create({
    data: {
      sNameCareers: "Mathematics",
      bStateCareers: true,
      fkIdCareerCoord: tutorUser.iIdUsers,
      fkIdFaculties: scienceFaculty.iIdFaculties,
    },
  });

  return {
    engCareer,
    mathCareer,
  };
}
