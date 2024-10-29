'use client'

import { useEffect, useState } from "react";
import axios from "axios";
import * as Form from "@radix-ui/react-form";
import FormFieldSlider, { FormTextField } from "@/component/Forms";
import { useRouter } from "next/navigation";
import { Box, Card, Flex, Grid, Text } from "@radix-ui/themes";
import Image from "next/image";
import * as Tabs from "@radix-ui/react-tabs";
import logoPng from "@/public/newlogo.png";
import loginBgJpg from "@/public/loginbg.jpg";
import LoadingSkeleton from "./ui/common/loadingSkeleton";
import * as Primitive from '@radix-ui/react-primitive';
const daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];

const MealPlanList: React.FC<any> = ({ mealPlans }) => {
  return (
    <div className="flex flex-col gap-6">
      {mealPlans?.map((plan: any, index: number) => (
        <div
          key={index}
          className="p-6 border border-gray-200 rounded-lg shadow-lg bg-white transition-transform transform hover:scale-105"
        >
          <h2 className="text-md font-semibold mb-4 text-gray-800">
            {daysOfWeek[index % daysOfWeek.length]}
          </h2>
          <div className="space-y-2 text-gray-700 text-sm">
            <p><span className="font-medium">Breakfast:</span> {plan.Breakfast}</p>
            <p><span className="font-medium">Lunch:</span> {plan.Lunch}</p>
            <p><span className="font-medium">Dinner:</span> {plan.Dinner}</p>
            <p><span className="font-medium">Total Calories:</span> {plan["Total Energy(Kcal)"]} Kcal</p>
            <p><span className="font-medium">Total Protein:</span> {plan["Total Protein(g)"]} g</p>
            <p className="font-bold"><span>Price:</span> LKR {plan.Price.toFixed(2)}</p>
          </div>
        </div>
      ))}
    </div>
  );
};

const PredictionForm = ({ params }: { params: any }) => {
  const [predictionData, setPredictionData] = useState<any>(null);
  const router = useRouter();

  const [step, setStep] = useState(1);

  const [price, setPrice] = useState<number | undefined>(0);
  const [age, setAge] = useState<number | undefined>(0);
  const [weight, setWeight] = useState<number | undefined>(0);
  const [height, setHeight] = useState<number | undefined>(0);
  const [diabetesLevel, setDiabetesLevel] = useState<number>(0);
  const [pressureLevel, setPressureLevel] = useState<number>(0);
  const [cholesterolLevel, setCholesterolLevel] = useState<number>(0);
  const [activityLevel, setActivityLevel] = useState<number>(0);


  const [mealPlans, setMealPlans] = useState<any[]>([]);
  const [loadingMealPlans, setLoadingMealPlans] = useState<boolean>(false);

  const fetchPrediction = async () => {
    try {
      setLoadingMealPlans(true);

      let a = 'sedentary';
      if (activityLevel <= 2) {
        a = 'lightly active'
      } else if (activityLevel <= 4) {
        a = 'moderately active'
      } else if (activityLevel <= 7) {
        a =  'very active'
      } else if (activityLevel <= 10) {
        a =  'extra active'
      }

      const requestData = {
        weight,
        height,
        age,
        gender: "male",
        activity_level: a,
        price: 1000,
        diabetes_input: diabetesLevel,
        pressure_input: pressureLevel,
        chol_input: cholesterolLevel,
      };

      const response = await axios.post('/api/prediction', requestData);
      setMealPlans(response.data?.prediction);
    } catch (error) {
      console.error('Error fetching meal plans:', error);
    } finally {
      setLoadingMealPlans(false);
    }
  };


  useEffect(() => {
    if (step === 2) fetchPrediction(); // Trigger when moving to step 2
  }, [step]);


  return (
    <Tabs.Root value={String(step)} className={`${step == 1 ? 'max-w-md' : 'max-w-lg'} mx-auto`}>
      <Tabs.Content value="1">
        <Form.Root className="overflow-scroll">
          <FormTextField
            label="Age"
            name="age"
            type="number"
            value={age ?? ''}
            onChange={(e) => setAge(Number(e.target.value))}
            placeholder="Enter age"
          />
          <FormTextField
            label="Price"
            name="price"
            type="number"
            value={price ?? ''}
            onChange={(e) => setPrice(Number(e.target.value))}
            placeholder="Enter how much you can spend on foods per day"
          />

          <div className="grid grid-cols-2 gap-3">
            <FormTextField
              label="Height (cm)"
              name="height"
              type="number"
              value={height ?? ''}
              onChange={(e) => setHeight(Number(e.target.value))}
              placeholder="Enter height"
            />
            <FormTextField
              label="Weight (kg)"
              name="weight"
              type="number"
              value={weight ?? ''}
              onChange={(e) => setWeight(Number(e.target.value))}
              placeholder="Enter weight"
            />
          </div>

          <FormFieldSlider
            label="Diabetes Level"
            name="diabetesLevel"
            min={0}
            max={10}
            step={2}
            value={diabetesLevel}
            onChange={(value) => setDiabetesLevel(value)}
          />

          <FormFieldSlider
            label="Pressure Level"
            name="pressureLevel"
            min={0}
            max={10}
            step={2}
            value={pressureLevel}
            onChange={(value) => setPressureLevel(value)}
          />

          <FormFieldSlider
            label="Cholesterol Level"
            name="cholesterolLevel"
            min={0}
            max={10}
            step={2}
            value={cholesterolLevel}
            onChange={(value) => setCholesterolLevel(value)}
          />

          <FormFieldSlider
            label="Exercise Level For Week (Sedentary - Very Active)"
            name="activityLevel"
            min={0}
            max={10}
            step={2}
            value={activityLevel}
            onChange={(value) => setActivityLevel(value)}
          />


          <div className="mt-[25px] flex justify-end">
            <button onClick={() => setStep(2)} className="inline-flex h-[35px] items-center justify-center rounded bg-green4 px-[15px] font-medium leading-none text-green11 hover:bg-green5 focus:shadow-[0_0_0_2px] focus:shadow-green7 focus:outline-none">
              Get Your Customized Meal Plan
            </button>
          </div>
        </Form.Root>
      </Tabs.Content>
      <Tabs.Content value="2">
        {loadingMealPlans && <>
          <Text as="div" align={'center'} weight={'bold'} size="1" style={{ width: '100%' }}>
            Cool bot is generating a meal plan for you. Stay back...
          </Text>
          <LoadingSkeleton />
        </>}



        <MealPlanList mealPlans={mealPlans} />
      </Tabs.Content>
    </Tabs.Root>
  );
};

const PredictionPage: React.FC<any> = ({ params }) => {
  return (
    <div className="flex items-center justify-center min-h-screen bg-gray-100" style={{ backgroundImage: `url(${loginBgJpg.src})`, backgroundSize: 'cover' }}>
      <div className="w-full max-w-lg bg-white shadow-lg px-16 overflow-scroll max-h-fit py-10">

        <div className="flex items-center justify-between flex-col">
          <Image
            className="mb-8"
            src={logoPng}
            width={120}
            height={120}
            alt="Picture"
          />
        </div>

        <PredictionForm params={params} />
      </div>
    </div>
  );
};

export default PredictionPage;
