export async function seedUserTypes(prisma) {
  const [adminType, tutorType, professorType, studentType] = await Promise.all([
    prisma.user_Types.create({
      data: {
        sNameUserTypes: "ADMIN",
        bStateUserTypes: true,
      },
    }),
    prisma.user_Types.create({
      data: {
        sNameUserTypes: "TUTOR",
        bStateUserTypes: true,
      },
    }),
    prisma.user_Types.create({
      data: {
        sNameUserTypes: "PROFESSOR",
        bStateUserTypes: true,
      },
    }),
    prisma.user_Types.create({
      data: {
        sNameUserTypes: "STUDENT",
        bStateUserTypes: true,
      },
    }),
  ]);

  return {
    adminType,
    tutorType,
    professorType,
    studentType,
  };
}

export async function seedUsers(prisma, userTypes) {
  const { adminType, tutorType, professorType, studentType } = userTypes;

  const adminUser = await prisma.users.create({
    data: {
      sFullNameUsers: "Alice Admin",
      iEnrollmentUsers: 1000,
      sPasswordUser: "password123",
      sGender: "F",
      sInstitutionalEmail: "alice.admin@uni.edu",
      sPhone: "+5215550001000",
      sLocation: "Main campus",
      bStateUsers: true,
      userTypes: { connect: { iIdUserTypes: adminType.iIdUserTypes } },
    },
  });

  const professorUser = await prisma.users.create({
    data: {
      sFullNameUsers: "Dr. Bob Professor",
      iEnrollmentUsers: 2000,
      sPasswordUser: "password123",
      sGender: "M",
      sInstitutionalEmail: "bob.prof@uni.edu",
      sPhone: "+5215550002000",
      sLocation: "Science Building",
      bStateUsers: true,
      userTypes: { connect: { iIdUserTypes: professorType.iIdUserTypes } },
    },
  });

  const tutorUser = await prisma.users.create({
    data: {
      sFullNameUsers: "Carlos Tutor",
      iEnrollmentUsers: 3000,
      sPasswordUser: "password123",
      sGender: "M",
      sInstitutionalEmail: "carlos.tutor@uni.edu",
      sPhone: "+5215550003000",
      sLocation: "Dept. of Engineering",
      bStateUsers: true,
      userTypes: { connect: { iIdUserTypes: tutorType.iIdUserTypes } },
    },
  });

  const studentUser = await prisma.users.create({
    data: {
      sFullNameUsers: "Diana Student",
      iEnrollmentUsers: 4000,
      sPasswordUser: "password123",
      sGender: "F",
      sInstitutionalEmail: "diana.student@uni.edu",
      sPhone: "+5215550004000",
      sLocation: "Main campus",
      bStateUsers: true,
      userTypes: { connect: { iIdUserTypes: studentType.iIdUserTypes } },
    },
  });

  return {
    adminUser,
    professorUser,
    tutorUser,
    studentUser,
  };
}
