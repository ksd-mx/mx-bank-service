import { Injectable } from '@nestjs/common';
import { Account } from '../entities/account.entity';
import { AccountsService } from '../accounts.service';

@Injectable()
export class AccountStorageService {
    private accounts: Account | null = null;

    constructor (private accountSevice: AccountsService) {}

    setBy(token: string) {}
}
