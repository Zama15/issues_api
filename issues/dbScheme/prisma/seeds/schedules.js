export async function seedSchedules(
  prisma,
  cycles,
  classrooms,
  courseAssignments
) {
  const { cycle2025A } = cycles;
  const { class101, lab201 } = classrooms;
  const { caCalculus, caProgramming } = courseAssignments;

  const schedule1 = await prisma.schedules.create({
    data: {
      dtStartCourses: new Date("2025-02-01T08:00:00Z"),
      dtEndCourses: new Date("2025-06-30T10:00:00Z"),
      fkIdCycles: cycle2025A.iIdCycles,
      fkIdClassrooms: class101.iIdClassrooms,
      fkIdCourseAssignments: caCalculus.iIdCourseAssignments,
    },
  });

  const schedule2 = await prisma.schedules.create({
    data: {
      dtStartCourses: new Date("2025-02-01T10:00:00Z"),
      dtEndCourses: new Date("2025-06-30T12:00:00Z"),
      fkIdCycles: cycle2025A.iIdCycles,
      fkIdClassrooms: lab201.iIdClassrooms,
      fkIdCourseAssignments: caProgramming.iIdCourseAssignments,
    },
  });

  const schedule3 = await prisma.schedules.create({
    data: {
      dtStartCourses: new Date("2025-02-01T14:00:00Z"),
      dtEndCourses: new Date("2025-06-30T16:00:00Z"),
      fkIdCycles: cycle2025A.iIdCycles,
      fkIdClassrooms: class101.iIdClassrooms,
      fkIdCourseAssignments: caProgramming.iIdCourseAssignments,
    },
  });

  return {
    schedule1,
    schedule2,
    schedule3,
  };
}
