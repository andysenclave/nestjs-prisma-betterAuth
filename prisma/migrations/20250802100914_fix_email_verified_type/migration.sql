/*
  Warnings:

  - The `email_verified` column on the `user` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- AlterTable
ALTER TABLE "public"."user" DROP COLUMN "email_verified",
ADD COLUMN     "email_verified" BOOLEAN NOT NULL DEFAULT false;
