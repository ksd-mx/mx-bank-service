import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { OrdersModule } from './orders/orders.module';
import { SequelizeModule } from '@nestjs/sequelize';
import { join } from 'path';
import { Order } from './orders/entities/order.entity';
import { AccountsModule } from './accounts/accounts.module';
import { Account } from './accounts/entities/account.entity';

@Module({
  imports: [
    OrdersModule,
    AccountsModule, 
    SequelizeModule.forRoot({
      dialect: 'sqlite',
      host: join(__dirname, 'database.sqlite'),
      autoLoadModels: true,
      sync: { alter: true, force: true },
      models: [Order, Account],
    })],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
