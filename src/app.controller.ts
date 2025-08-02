import {
  Controller,
  Get,
  Param,
  Post,
  Body,
  Put,
  Delete,
  UseGuards,
} from '@nestjs/common';
import { UserService } from './user/user.service';
import { PostsService } from './post/post.service';
import { Post as PostModel, User as UserModel } from 'generated/prisma';
import * as nestjsBetterAuth from '@thallesp/nestjs-better-auth';

@Controller()
export class AppController {
  constructor(
    private readonly userService: UserService,
    private readonly postService: PostsService,
  ) {}

  @Get('post/:id')
  async getPostById(@Param('id') id: string): Promise<PostModel> {
    const post = await this.postService.post({ id: Number(id) });
    if (!post) {
      throw new Error(`Post with id ${id} not found`);
    }
    return post;
  }

  @UseGuards(nestjsBetterAuth.AuthGuard)
  @Get('feed')
  async getPublishedPosts(): Promise<PostModel[]> {
    return this.postService.posts({
      where: { published: true },
    });
  }

  @Get('filtered-posts/:searchString')
  async getFilteredPosts(
    @Param('searchString') searchString: string,
  ): Promise<PostModel[]> {
    return this.postService.posts({
      where: {
        OR: [
          {
            title: { contains: searchString },
          },
          {
            content: { contains: searchString },
          },
        ],
      },
    });
  }

  @Post('post')
  async createDraft(
    @Body() postData: { title: string; content?: string; authorId: string },
  ): Promise<PostModel> {
    const { title, content, authorId } = postData;
    return this.postService.createPost({
      title,
      content,
      author: {
        connect: { id: authorId },
      },
    });
  }

  @Post('user')
  async signupUser(
    @Body() userData: { name?: string; email: string },
  ): Promise<UserModel> {
    return this.userService.createUser({
      ...userData,
      createdAt: new Date(),
      updatedAt: new Date(),
    });
  }

  @Put('publish/:id')
  async publishPost(@Param('id') id: string): Promise<PostModel> {
    return this.postService.updatePost({
      where: { id: Number(id) },
      data: { published: true },
    });
  }

  @Delete('post/:id')
  async deletePost(@Param('id') id: string): Promise<PostModel> {
    return this.postService.deletePost({ id: Number(id) });
  }
}
