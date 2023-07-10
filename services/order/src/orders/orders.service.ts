import { Injectable } from '@nestjs/common';
import { CreateOrderDto } from './dto/create-order.dto';
import { UpdateOrderDto } from './dto/update-order.dto';
import { InjectModel } from '@nestjs/sequelize';
import { Order } from './entities/order.entity';

@Injectable()
export class OrdersService {
  constructor(
    @InjectModel(Order)
    private orderModel: typeof Order
  ) {}

  create(createOrderDto: CreateOrderDto) {
    return this.orderModel.create({ ...createOrderDto });
  }

  findAll() {
    return this.orderModel.findAll();
  }

  findOne(id: string) {
    return this.orderModel.findByPk(id);
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
