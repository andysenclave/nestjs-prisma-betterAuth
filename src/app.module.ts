import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { PostsService } from './post/post.service';
import { PrismaService } from './prisma/prisma.service';
import { UserService } from './user/user.service';
import { AuthModule } from '@thallesp/nestjs-better-auth';
import { auth } from './lib/auth';
import { UserController } from './user/user.controller';

@Module({
  imports: [AuthModule.forRoot(auth)],
  controllers: [AppController, UserController],
  providers: [PostsService, PrismaService, UserService],
})
export class AppModule {}
