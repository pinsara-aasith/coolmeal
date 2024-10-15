import mongoose, { Document, Model, Schema } from 'mongoose';


// Define TypeScript interfaces for your models
interface IUser extends Document {
  email: string;
  password: string;
  name: string;
  refreshToken?: string;
  // twoFactorToken?: string;
}

const UserSchema: Schema<IUser> = new Schema({
  email: { type: String, unique: true, required: false, index: true },
  password: { type: String, required: true },
  name: { type: String, required: true },
  refreshToken: { type: String, index: true },
  // twoFactorToken: { type: String },
});

// Create models
const User: Model<IUser> = mongoose?.models?.User || mongoose.model<IUser>('User', UserSchema);


export { User };
export type { IUser };

