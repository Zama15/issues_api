export async function seedCycles(prisma) {
  const cycle2025A = await prisma.cycles.create({
    data: {
      sNameCycles: "2025-A",
      bStateCycles: true,
    },
  });

  const cycle2025B = await prisma.cycles.create({
    data: {
      sNameCycles: "2025-B",
      bStateCycles: true,
    },
  });

  return {
    cycle2025A,
    cycle2025B,
  };
}

export async function seedCourses(prisma) {
  const calculusCourse = await prisma.courses.create({
    data: {
      sNameCourses: "Calculus I",
      bStateCourses: true,
    },
  });

  const programmingCourse = await prisma.courses.create({
    data: {
      sNameCourses: "Intro to Programming",
      bStateCourses: true,
    },
  });

  const physicsCourse = await prisma.courses.create({
    data: {
      sNameCourses: "Physics I",
      bStateCourses: true,
    },
  });

  return {
    calculusCourse,
    programmingCourse,
    physicsCourse,
  };
}

export async function seedCourseAssignments(prisma, courses, professorUser) {
  const { calculusCourse, programmingCourse, physicsCourse } = courses;

  const caCalculus = await prisma.course_Assignments.create({
    data: {
      iCourseTotalHours: 64,
      bStateCourses: true,
      fkIdCourses: calculusCourse.iIdCourses,
      fkIdProfessor: professorUser.iIdUsers,
    },
  });

  const caProgramming = await prisma.course_Assignments.create({
    data: {
      iCourseTotalHours: 80,
      bStateCourses: true,
      fkIdCourses: programmingCourse.iIdCourses,
      fkIdProfessor: professorUser.iIdUsers,
    },
  });

  const caPhysics = await prisma.course_Assignments.create({
    data: {
      iCourseTotalHours: 72,
      bStateCourses: true,
      fkIdCourses: physicsCourse.iIdCourses,
      fkIdProfessor: professorUser.iIdUsers,
    },
  });

  return {
    caCalculus,
    caProgramming,
    caPhysics,
  };
}
