import { Table, Model, Column, DataType, PrimaryKey, ForeignKey, BelongsTo } from 'sequelize-typescript';
import { Account } from 'src/accounts/entities/account.entity';

export enum OrderStatus {
    Pending = "pending",
    Approved = "approved",
    Rejected = "rejected",
}

@Table({
    tableName: "orders",
    createdAt: "created_at",
    updatedAt: "updated_at",
})
export class Order extends Model {
    @PrimaryKey
    @Column({ type: DataType.UUID, primaryKey: true, defaultValue: DataType.UUIDV4 })
    id: string;

    @ForeignKey(() => Account)
    @Column({ allowNull: false, type: DataType.UUID })
    accountId: string;
    
    @Column({ allowNull: false, type: DataType.DECIMAL(10, 2) })
    amountId: number;

    @BelongsTo(() => Account)
    account: Account;
    
    @Column({ allowNull: false, field: "credit_card_number" })
    creditCardNumber: string;
    
    @Column({ allowNull: false, field: "credit_card_name" })
    creditCardName: string;

    @Column({ allowNull: false, defaultValue: OrderStatus.Pending })
    status: OrderStatus;
}
