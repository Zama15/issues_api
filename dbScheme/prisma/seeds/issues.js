export async function seedSeverities(prisma) {
  const [sevLow, sevMedium, sevHigh, sevCritical] = await Promise.all([
    prisma.severities.create({
      data: {
        sNameSeverities: "LOW",
        bStateSeverities: true,
      },
    }),
    prisma.severities.create({
      data: {
        sNameSeverities: "MEDIUM",
        bStateSeverities: true,
      },
    }),
    prisma.severities.create({
      data: {
        sNameSeverities: "HIGH",
        bStateSeverities: true,
      },
    }),
    prisma.severities.create({
      data: {
        sNameSeverities: "CRITICAL",
        bStateSeverities: true,
      },
    }),
  ]);

  return {
    sevLow,
    sevMedium,
    sevHigh,
    sevCritical,
  };
}

export async function seedIssueTypes(prisma) {
  const [itMaintenance, itBehavior, itTechnical, itSecurity] =
    await Promise.all([
      prisma.issue_Types.create({
        data: {
          sNameIssuesTypes: "MAINTENANCE",
          sDescriptionIssuesTypes:
            "Problems with physical facilities or equipment",
          bStateIssuesTypes: true,
        },
      }),
      prisma.issue_Types.create({
        data: {
          sNameIssuesTypes: "BEHAVIOR",
          sDescriptionIssuesTypes: "Student or staff behavioral reports",
          bStateIssuesTypes: true,
        },
      }),
      prisma.issue_Types.create({
        data: {
          sNameIssuesTypes: "TECHNICAL",
          sDescriptionIssuesTypes: "IT and technology-related issues",
          bStateIssuesTypes: true,
        },
      }),
      prisma.issue_Types.create({
        data: {
          sNameIssuesTypes: "SECURITY",
          sDescriptionIssuesTypes: "Safety and security concerns",
          bStateIssuesTypes: true,
        },
      }),
    ]);

  return {
    itMaintenance,
    itBehavior,
    itTechnical,
    itSecurity,
  };
}

export async function seedIssues(
  prisma,
  issueTypes,
  severities,
  classrooms,
  users
) {
  const { itMaintenance, itBehavior, itTechnical, itSecurity } = issueTypes;
  const { sevLow, sevHigh, sevMedium, sevCritical } = severities;
  const { class101, lab201 } = classrooms;
  const { studentUser, tutorUser, adminUser, professorUser } = users;

  // Original issues
  const issue1 = await prisma.issues.create({
    data: {
      tDate: new Date("2025-03-10T09:30:00Z"),
      sIssueContent: "Projector not working in Room 101",
      eStatus: "FOR_REVIEW",
      bStateIssues: true,
      fkIdIssueTypes: itMaintenance.iIdIssuesTypes,
      fkIdSeverities: sevLow.iIdSeverities,
      fkIdClassrooms: class101.iIdClassrooms,
      fkIdUserRegister: studentUser.iIdUsers,
      fkIdUserReviewer: adminUser.iIdUsers,
    },
  });

  const issue2 = await prisma.issues.create({
    data: {
      tDate: new Date("2024-04-01T14:00:00Z"),
      sIssueContent: "Disruptive behavior during Lab 201 session",
      eStatus: "REVIEWED",
      bStateIssues: true,
      fkIdIssueTypes: itBehavior.iIdIssuesTypes,
      fkIdSeverities: sevHigh.iIdSeverities,
      fkIdClassrooms: lab201.iIdClassrooms,
      fkIdUserRegister: tutorUser.iIdUsers,
      fkIdUserReviewer: adminUser.iIdUsers,
    },
  });

  const issue3 = await prisma.issues.create({
    data: {
      tDate: new Date("2025-04-15T11:15:00Z"),
      sIssueContent: "Internet connection unstable in Lab 201",
      eStatus: "FOR_REVIEW",
      bStateIssues: true,
      fkIdIssueTypes: itTechnical.iIdIssuesTypes,
      fkIdSeverities: sevMedium.iIdSeverities,
      fkIdClassrooms: lab201.iIdClassrooms,
      fkIdUserRegister: studentUser.iIdUsers,
      fkIdUserReviewer: adminUser.iIdUsers,
    },
  });

  // Additional MAINTENANCE issues
  const issue4 = await prisma.issues.create({
    data: {
      tDate: new Date("2024-03-15T08:45:00Z"),
      sIssueContent: "Air conditioning unit making loud noises in Room 101",
      eStatus: "FOR_REVIEW",
      bStateIssues: true,
      fkIdIssueTypes: itMaintenance.iIdIssuesTypes,
      fkIdSeverities: sevMedium.iIdSeverities,
      fkIdClassrooms: class101.iIdClassrooms,
      fkIdUserRegister: professorUser.iIdUsers,
      fkIdUserReviewer: adminUser.iIdUsers,
    },
  });

  const issue5 = await prisma.issues.create({
    data: {
      tDate: new Date("2025-03-20T16:30:00Z"),
      sIssueContent: "Broken chair in Lab 201, potential safety hazard",
      eStatus: "RESOLVED",
      bStateIssues: true,
      fkIdIssueTypes: itMaintenance.iIdIssuesTypes,
      fkIdSeverities: sevHigh.iIdSeverities,
      fkIdClassrooms: lab201.iIdClassrooms,
      fkIdUserRegister: tutorUser.iIdUsers,
      fkIdUserReviewer: adminUser.iIdUsers,
    },
  });

  const issue6 = await prisma.issues.create({
    data: {
      tDate: new Date("2025-04-05T13:20:00Z"),
      sIssueContent: "Whiteboard markers dried out, need replacement",
      eStatus: "RESOLVED",
      bStateIssues: true,
      fkIdIssueTypes: itMaintenance.iIdIssuesTypes,
      fkIdSeverities: sevLow.iIdSeverities,
      fkIdClassrooms: class101.iIdClassrooms,
      fkIdUserRegister: studentUser.iIdUsers,
      fkIdUserReviewer: adminUser.iIdUsers,
    },
  });

  // Additional BEHAVIOR issues
  const issue7 = await prisma.issues.create({
    data: {
      tDate: new Date("2025-03-25T10:15:00Z"),
      sIssueContent: "Student using phone during lecture, disrupting others",
      eStatus: "REVIEWED",
      bStateIssues: true,
      fkIdIssueTypes: itBehavior.iIdIssuesTypes,
      fkIdSeverities: sevLow.iIdSeverities,
      fkIdClassrooms: class101.iIdClassrooms,
      fkIdUserRegister: professorUser.iIdUsers,
      fkIdUserReviewer: adminUser.iIdUsers,
    },
  });

  const issue8 = await prisma.issues.create({
    data: {
      tDate: new Date("2024-04-08T15:45:00Z"),
      sIssueContent: "Inappropriate language and harassment towards classmates",
      eStatus: "FOR_REVIEW",
      bStateIssues: true,
      fkIdIssueTypes: itBehavior.iIdIssuesTypes,
      fkIdSeverities: sevCritical.iIdSeverities,
      fkIdClassrooms: lab201.iIdClassrooms,
      fkIdUserRegister: tutorUser.iIdUsers,
      fkIdUserReviewer: adminUser.iIdUsers,
    },
  });

  const issue9 = await prisma.issues.create({
    data: {
      tDate: new Date("2025-04-12T09:00:00Z"),
      sIssueContent: "Students arriving consistently late and disrupting class",
      eStatus: "FOR_REVIEW",
      bStateIssues: true,
      fkIdIssueTypes: itBehavior.iIdIssuesTypes,
      fkIdSeverities: sevMedium.iIdSeverities,
      fkIdClassrooms: class101.iIdClassrooms,
      fkIdUserRegister: professorUser.iIdUsers,
      fkIdUserReviewer: adminUser.iIdUsers,
    },
  });

  // Additional TECHNICAL issues
  const issue10 = await prisma.issues.create({
    data: {
      tDate: new Date("2025-03-18T11:30:00Z"),
      sIssueContent:
        "Computers in Lab 201 running very slowly, affecting productivity",
      eStatus: "FOR_REVIEW",
      bStateIssues: true,
      fkIdIssueTypes: itTechnical.iIdIssuesTypes,
      fkIdSeverities: sevHigh.iIdSeverities,
      fkIdClassrooms: lab201.iIdClassrooms,
      fkIdUserRegister: studentUser.iIdUsers,
      fkIdUserReviewer: adminUser.iIdUsers,
    },
  });

  const issue11 = await prisma.issues.create({
    data: {
      tDate: new Date("2024-04-03T14:20:00Z"),
      sIssueContent:
        "Software license expired, unable to access required applications",
      eStatus: "RESOLVED",
      bStateIssues: true,
      fkIdIssueTypes: itTechnical.iIdIssuesTypes,
      fkIdSeverities: sevCritical.iIdSeverities,
      fkIdClassrooms: lab201.iIdClassrooms,
      fkIdUserRegister: tutorUser.iIdUsers,
      fkIdUserReviewer: adminUser.iIdUsers,
    },
  });

  const issue12 = await prisma.issues.create({
    data: {
      tDate: new Date("2025-04-10T16:00:00Z"),
      sIssueContent: "Audio system not working properly in Room 101",
      eStatus: "FOR_REVIEW",
      bStateIssues: true,
      fkIdIssueTypes: itTechnical.iIdIssuesTypes,
      fkIdSeverities: sevMedium.iIdSeverities,
      fkIdClassrooms: class101.iIdClassrooms,
      fkIdUserRegister: professorUser.iIdUsers,
      fkIdUserReviewer: adminUser.iIdUsers,
    },
  });

  // Additional SECURITY issues
  const issue13 = await prisma.issues.create({
    data: {
      tDate: new Date("2025-03-22T12:00:00Z"),
      sIssueContent: "Unauthorized person found in Lab 201 after hours",
      eStatus: "REVIEWED",
      bStateIssues: true,
      fkIdIssueTypes: itSecurity.iIdIssuesTypes,
      fkIdSeverities: sevHigh.iIdSeverities,
      fkIdClassrooms: lab201.iIdClassrooms,
      fkIdUserRegister: adminUser.iIdUsers,
      fkIdUserReviewer: adminUser.iIdUsers,
    },
  });

  const issue14 = await prisma.issues.create({
    data: {
      tDate: new Date("2025-04-07T07:30:00Z"),
      sIssueContent: "Door lock malfunction in Room 101, security concern",
      eStatus: "FOR_REVIEW",
      bStateIssues: true,
      fkIdIssueTypes: itSecurity.iIdIssuesTypes,
      fkIdSeverities: sevCritical.iIdSeverities,
      fkIdClassrooms: class101.iIdClassrooms,
      fkIdUserRegister: tutorUser.iIdUsers,
      fkIdUserReviewer: adminUser.iIdUsers,
    },
  });

  const issue15 = await prisma.issues.create({
    data: {
      tDate: new Date("2025-04-14T13:45:00Z"),
      sIssueContent: "Suspicious activity near emergency exit in Lab 201",
      eStatus: "FOR_REVIEW",
      bStateIssues: true,
      fkIdIssueTypes: itSecurity.iIdIssuesTypes,
      fkIdSeverities: sevMedium.iIdSeverities,
      fkIdClassrooms: lab201.iIdClassrooms,
      fkIdUserRegister: studentUser.iIdUsers,
      fkIdUserReviewer: adminUser.iIdUsers,
    },
  });

  return {
    issue1,
    issue2,
    issue3,
    issue4,
    issue5,
    issue6,
    issue7,
    issue8,
    issue9,
    issue10,
    issue11,
    issue12,
    issue13,
    issue14,
    issue15,
  };
}

export async function seedIssueRelations(prisma, issues, users) {
  const {
    issue1,
    issue2,
    issue3,
    issue4,
    issue5,
    issue6,
    issue7,
    issue8,
    issue9,
    issue10,
    issue11,
    issue12,
    issue13,
    issue14,
    issue15,
  } = issues;
  const { studentUser, tutorUser, professorUser } = users;

  // Issue culprits and affected (many-to-many joins)
  await Promise.all([
    // Original relations
    // Mark studentUser as culprit of issue2
    prisma.issue_Culprits.create({
      data: {
        fkIdIssues: issue2.iIdIssues,
        fkIdUsers: studentUser.iIdUsers,
      },
    }),

    // Mark tutorUser as affected by issue1
    prisma.issue_Affected.create({
      data: {
        fkIdIssues: issue1.iIdIssues,
        fkIdUsers: tutorUser.iIdUsers,
      },
    }),

    // Mark professorUser as affected by issue2
    prisma.issue_Affected.create({
      data: {
        fkIdIssues: issue2.iIdIssues,
        fkIdUsers: professorUser.iIdUsers,
      },
    }),

    // Mark multiple users affected by issue3 (network issue)
    prisma.issue_Affected.create({
      data: {
        fkIdIssues: issue3.iIdIssues,
        fkIdUsers: studentUser.iIdUsers,
      },
    }),
    prisma.issue_Affected.create({
      data: {
        fkIdIssues: issue3.iIdIssues,
        fkIdUsers: professorUser.iIdUsers,
      },
    }),

    // Additional relations for new issues

    // Air conditioning issue affects everyone in the room
    prisma.issue_Affected.create({
      data: {
        fkIdIssues: issue4.iIdIssues,
        fkIdUsers: studentUser.iIdUsers,
      },
    }),
    prisma.issue_Affected.create({
      data: {
        fkIdIssues: issue4.iIdIssues,
        fkIdUsers: tutorUser.iIdUsers,
      },
    }),

    // Broken chair affects students
    prisma.issue_Affected.create({
      data: {
        fkIdIssues: issue5.iIdIssues,
        fkIdUsers: studentUser.iIdUsers,
      },
    }),

    // Phone disruption - mark student as culprit
    prisma.issue_Culprits.create({
      data: {
        fkIdIssues: issue7.iIdIssues,
        fkIdUsers: studentUser.iIdUsers,
      },
    }),
    // Professor affected by phone disruption
    prisma.issue_Affected.create({
      data: {
        fkIdIssues: issue7.iIdIssues,
        fkIdUsers: professorUser.iIdUsers,
      },
    }),

    // Harassment case - mark student as culprit
    prisma.issue_Culprits.create({
      data: {
        fkIdIssues: issue8.iIdIssues,
        fkIdUsers: studentUser.iIdUsers,
      },
    }),
    // Multiple users affected by harassment
    prisma.issue_Affected.create({
      data: {
        fkIdIssues: issue8.iIdIssues,
        fkIdUsers: tutorUser.iIdUsers,
      },
    }),
    prisma.issue_Affected.create({
      data: {
        fkIdIssues: issue8.iIdIssues,
        fkIdUsers: professorUser.iIdUsers,
      },
    }),

    // Late arrivals - students as culprits
    prisma.issue_Culprits.create({
      data: {
        fkIdIssues: issue9.iIdIssues,
        fkIdUsers: studentUser.iIdUsers,
      },
    }),

    // Slow computers affect all users in lab
    prisma.issue_Affected.create({
      data: {
        fkIdIssues: issue10.iIdIssues,
        fkIdUsers: tutorUser.iIdUsers,
      },
    }),
    prisma.issue_Affected.create({
      data: {
        fkIdIssues: issue10.iIdIssues,
        fkIdUsers: professorUser.iIdUsers,
      },
    }),

    // Software license affects all lab users
    prisma.issue_Affected.create({
      data: {
        fkIdIssues: issue11.iIdIssues,
        fkIdUsers: studentUser.iIdUsers,
      },
    }),
    prisma.issue_Affected.create({
      data: {
        fkIdIssues: issue11.iIdIssues,
        fkIdUsers: professorUser.iIdUsers,
      },
    }),

    // Audio system affects professor primarily
    prisma.issue_Affected.create({
      data: {
        fkIdIssues: issue12.iIdIssues,
        fkIdUsers: studentUser.iIdUsers,
      },
    }),

    // Security issues affect everyone
    prisma.issue_Affected.create({
      data: {
        fkIdIssues: issue13.iIdIssues,
        fkIdUsers: studentUser.iIdUsers,
      },
    }),
    prisma.issue_Affected.create({
      data: {
        fkIdIssues: issue13.iIdIssues,
        fkIdUsers: tutorUser.iIdUsers,
      },
    }),

    // Door lock affects all room users
    prisma.issue_Affected.create({
      data: {
        fkIdIssues: issue14.iIdIssues,
        fkIdUsers: studentUser.iIdUsers,
      },
    }),
    prisma.issue_Affected.create({
      data: {
        fkIdIssues: issue14.iIdIssues,
        fkIdUsers: professorUser.iIdUsers,
      },
    }),

    // Suspicious activity affects lab users
    prisma.issue_Affected.create({
      data: {
        fkIdIssues: issue15.iIdIssues,
        fkIdUsers: tutorUser.iIdUsers,
      },
    }),
  ]);
}
