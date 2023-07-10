import { Injectable, Scope } from '@nestjs/common';
import { CreateAccountDto } from './dto/create-account.dto';
import { UpdateAccountDto } from './dto/update-account.dto';
import { Account } from './entities/account.entity';
import { InjectModel } from '@nestjs/sequelize';

@Injectable({ scope: Scope.REQUEST })
export class AccountsService {
  constructor(@InjectModel(Account) private accountsModel: typeof Account) {}

  create(createAccountDto: CreateAccountDto) {
    return this.accountsModel.create({ ...createAccountDto });
  }

  findAll() {
    return this.accountsModel.findAll();
  }

  findOne(id: string) {
    return this.accountsModel.findByPk(id);
  }

  async findByToken(token: string) {
    return await this.accountsModel.findOne({ where: { token } });
  }

  async update(id: string, updateAccountDto: UpdateAccountDto) {
    const item = await this.findOne(id);
    return item.update(updateAccountDto);
  }

  async remove(id: string) {
    const item = await this.findOne(id);
    return item.destroy(); 
  }
}
