import { Body, Controller, Post } from '@nestjs/common';
import { auth } from 'src/lib/auth';

@Controller('user')
export class UserController {
  constructor() {}

  @Post('signup')
  async signupUser(
    @Body() userData: { name: string; email: string; password: string },
  ): Promise<any> {
    try {
      if (!userData.email || !userData.password) {
        throw new Error('Email and password are required');
      }

      const result = await auth.api.signUpEmail({
        body: {
          name: userData.name,
          email: userData.email,
          password: userData.password,
        },
      });
      return result;
    } catch (error) {
      console.log('Error during user signup:', error);
      console.log('Error details:', JSON.stringify(error, null, 2));
      throw new Error(
        `User signup failed: ${error instanceof Error ? error.message : 'Unknown error'}`,
      );
    }
  }

  @Post('login')
  async loginUser(
    @Body() loginData: { email: string; password: string },
  ): Promise<any> {
    try {
      const result = await auth.api.signInEmail({
        body: {
          email: loginData.email,
          password: loginData.password,
        },
      });
      console.log('Login successful:', result);
      return result;
    } catch (error) {
      console.log('Error during user login:', error);
      throw new Error(
        `User login failed: ${error instanceof Error ? error.message : 'Unknown error'}`,
      );
    }
  }
}
