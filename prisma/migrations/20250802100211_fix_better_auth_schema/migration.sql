/*
  Warnings:

  - You are about to drop the column `access_token` on the `account` table. All the data in the column will be lost.
  - You are about to drop the column `expires_at` on the `account` table. All the data in the column will be lost.
  - You are about to drop the column `id_token` on the `account` table. All the data in the column will be lost.
  - You are about to drop the column `provider` on the `account` table. All the data in the column will be lost.
  - You are about to drop the column `provider_account_id` on the `account` table. All the data in the column will be lost.
  - You are about to drop the column `refresh_token` on the `account` table. All the data in the column will be lost.
  - You are about to drop the column `session_state` on the `account` table. All the data in the column will be lost.
  - You are about to drop the column `token_type` on the `account` table. All the data in the column will be lost.
  - You are about to drop the column `type` on the `account` table. All the data in the column will be lost.
  - You are about to drop the column `expires` on the `session` table. All the data in the column will be lost.
  - You are about to drop the column `session_token` on the `session` table. All the data in the column will be lost.
  - You are about to drop the column `expires` on the `verification_token` table. All the data in the column will be lost.
  - You are about to drop the column `token` on the `verification_token` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[token]` on the table `session` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `accountId` to the `account` table without a default value. This is not possible if the table is not empty.
  - Added the required column `providerId` to the `account` table without a default value. This is not possible if the table is not empty.
  - Added the required column `expiresAt` to the `session` table without a default value. This is not possible if the table is not empty.
  - Added the required column `token` to the `session` table without a default value. This is not possible if the table is not empty.
  - Added the required column `expiresAt` to the `verification_token` table without a default value. This is not possible if the table is not empty.
  - The required column `id` was added to the `verification_token` table with a prisma-level default value. This is not possible if the table is not empty. Please add this column as optional, then populate it before making it required.
  - Added the required column `updatedAt` to the `verification_token` table without a default value. This is not possible if the table is not empty.
  - Added the required column `value` to the `verification_token` table without a default value. This is not possible if the table is not empty.

*/
-- DropIndex
DROP INDEX "public"."account_provider_provider_account_id_key";

-- DropIndex
DROP INDEX "public"."session_session_token_key";

-- DropIndex
DROP INDEX "public"."verification_token_identifier_token_key";

-- DropIndex
DROP INDEX "public"."verification_token_token_key";

-- AlterTable
ALTER TABLE "public"."account" DROP COLUMN "access_token",
DROP COLUMN "expires_at",
DROP COLUMN "id_token",
DROP COLUMN "provider",
DROP COLUMN "provider_account_id",
DROP COLUMN "refresh_token",
DROP COLUMN "session_state",
DROP COLUMN "token_type",
DROP COLUMN "type",
ADD COLUMN     "accessToken" TEXT,
ADD COLUMN     "accessTokenExpiresAt" TIMESTAMP(3),
ADD COLUMN     "accountId" TEXT NOT NULL,
ADD COLUMN     "idToken" TEXT,
ADD COLUMN     "password" TEXT,
ADD COLUMN     "providerId" TEXT NOT NULL,
ADD COLUMN     "refreshToken" TEXT,
ADD COLUMN     "refreshTokenExpiresAt" TIMESTAMP(3);

-- AlterTable
ALTER TABLE "public"."session" DROP COLUMN "expires",
DROP COLUMN "session_token",
ADD COLUMN     "expiresAt" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "ipAddress" TEXT,
ADD COLUMN     "token" TEXT NOT NULL,
ADD COLUMN     "userAgent" TEXT;

-- AlterTable
ALTER TABLE "public"."verification_token" DROP COLUMN "expires",
DROP COLUMN "token",
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "expiresAt" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "id" TEXT NOT NULL,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "value" TEXT NOT NULL,
ADD CONSTRAINT "verification_token_pkey" PRIMARY KEY ("id");

-- CreateIndex
CREATE UNIQUE INDEX "session_token_key" ON "public"."session"("token");
