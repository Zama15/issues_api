import { PrismaClient } from "../generated/prisma/client.js";
import { seedUserTypes, seedUsers } from "./seeds/users.js";
import { seedFaculties, seedCareers } from "./seeds/academic.js";
import { seedClassroomTypes, seedClassrooms } from "./seeds/classrooms.js";
import {
  seedCycles,
  seedCourses,
  seedCourseAssignments,
} from "./seeds/courses.js";
import { seedGroups, seedGrades } from "./seeds/groups.js";
import { seedSchedules } from "./seeds/schedules.js";
import {
  seedSeverities,
  seedIssueTypes,
  seedIssues,
  seedIssueRelations,
} from "./seeds/issues.js";

const prisma = new PrismaClient();

async function main() {
  console.log("Start seeding...");

  try {
    // 1) User types and users
    console.log("Seeding user types...");
    const userTypes = await seedUserTypes(prisma);

    console.log("Seeding users...");
    const users = await seedUsers(prisma, userTypes);

    // 2) Academic structure
    console.log("Seeding faculties...");
    const faculties = await seedFaculties(prisma);

    console.log("Seeding careers...");
    const careers = await seedCareers(prisma, users.tutorUser, faculties);

    // 3) Groups and grades
    console.log("Seeding groups...");
    const groups = await seedGroups(prisma, careers, users.tutorUser);

    console.log("Seeding grades...");
    const grades = await seedGrades(prisma, groups);

    // 4) Classrooms
    console.log("Seeding classroom types...");
    const classroomTypes = await seedClassroomTypes(prisma);

    console.log("Seeding classrooms...");
    const classrooms = await seedClassrooms(
      prisma,
      classroomTypes,
      grades,
      groups
    );

    // 5) Courses and assignments
    console.log("Seeding cycles...");
    const cycles = await seedCycles(prisma);

    console.log("Seeding courses...");
    const courses = await seedCourses(prisma);

    console.log("Seeding course assignments...");
    const courseAssignments = await seedCourseAssignments(
      prisma,
      courses,
      users.professorUser
    );

    // 6) Schedules
    console.log("Seeding schedules...");
    const schedules = await seedSchedules(
      prisma,
      cycles,
      classrooms,
      courseAssignments
    );

    // 7) Issues system
    console.log("Seeding severities...");
    const severities = await seedSeverities(prisma);

    console.log("Seeding issue types...");
    const issueTypes = await seedIssueTypes(prisma);

    console.log("Seeding issues...");
    const issues = await seedIssues(
      prisma,
      issueTypes,
      severities,
      classrooms,
      users
    );

    console.log("Seeding issue relations...");
    await seedIssueRelations(prisma, issues, users);

    console.log("Seeding finished successfully!");
  } catch (error) {
    console.error("Seeding error:", error);
    throw error;
  }
}

main()
  .catch((e) => {
    console.error("Seeding failed:", e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
