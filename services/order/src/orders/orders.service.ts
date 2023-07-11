import { Injectable } from '@nestjs/common';
import { CreateOrderDto } from './dto/create-order.dto';
import { UpdateOrderDto } from './dto/update-order.dto';
import { InjectModel } from '@nestjs/sequelize';
import { Order } from './entities/order.entity';
import { AccountStorageService } from 'src/accounts/account-storage/account-storage.service';
import { EmptyResultError } from 'sequelize';

@Injectable()
export class OrdersService {
  constructor(
    @InjectModel(Order)
    private orderModel: typeof Order,
    private accountStorage: AccountStorageService
  ) {}

  create(createOrderDto: CreateOrderDto) {
    return this.orderModel.create({ 
      ...createOrderDto, 
      accountId: this.accountStorage.account.id 
    });
  }

  findAll() {
    return this.orderModel.findAll({ 
      where: { accountId: this.accountStorage.account.id }
    });
  }

  findOne(id: string) {
    return this.orderModel.findOne({ 
      where: { id, accountId: this.accountStorage.account.id }, 
      rejectOnEmpty: new EmptyResultError(`Order with ID ${id} not found`) 
    });
  }

  async update(id: string, updateOrderDto: UpdateOrderDto) {
    const item : any = await this.findOne(id);  
    return item.update(updateOrderDto);
  }

  async remove(id: string) {
    const item : any = await this.findOne(id);  
    return item.destroy();
  }
}
