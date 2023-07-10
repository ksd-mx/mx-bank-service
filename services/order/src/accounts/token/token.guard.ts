import { CanActivate, ExecutionContext, Injectable } from '@nestjs/common';
import { AccountStorageService } from '../account-storage/account-storage.service';

@Injectable()
export class TokenGuard implements CanActivate {
  constructor(private accountStorage: AccountStorageService) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const request : any = context.switchToHttp().getRequest();
    const token = request.headers?.['x-token'] as string;
    if (token) {
      try {
        await this.accountStorage.setBy(token);
        let result = this.accountStorage.account !== null;
        return result;
      } catch (error) {
        console.error(error);
        return false;
      }
    }
    return false;
  }
}
