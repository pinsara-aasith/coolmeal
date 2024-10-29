"use client";

import { Button } from "@radix-ui/themes";
import * as Dialog from "@radix-ui/react-dialog";
import { MdClose } from "react-icons/md";
import MealItemForm from "./mealItemForm";


export const MealItemDialogWithTriggerButton = (props: { triggerLabel: string }) => (
  <Dialog.Root>
    <Dialog.Trigger asChild>

      <Button className="hover:cursor-pointer" color={'green'} type={'button'}>
        {props.triggerLabel}
      </Button>

    </Dialog.Trigger>
    <Dialog.Portal>
      <Dialog.Overlay className="fixed inset-0 bg-blackA6 data-[state=open]:animate-overlayShow" />
      <Dialog.Content className="fixed left-1/2 top-1/2  w-[90vw] max-w-[850px] -translate-x-1/2 -translate-y-1/2 rounded-md bg-white p-[25px] shadow-[hsl(206_22%_7%_/_35%)_0px_10px_38px_-10px,_hsl(206_22%_7%_/_20%)_0px_10px_20px_-15px] focus:outline-none data-[state=open]:animate-contentShow">
        <Dialog.Title className="m-0 text-[17px] font-medium text-mauve12">
          Add New Meal
        </Dialog.Title>
        <Dialog.Description className="mb-1 mt-2.5 text-[15px] leading-normal text-mauve11">
          Submit a new meal for inclusion in the meal planning database.
        </Dialog.Description>

        <div className="overflow-scroll max-h-[53vh] p-4">
          <MealItemForm />
        </div>

        <Dialog.Close asChild>
          <button
            className="absolute right-2.5 top-2.5 inline-flex size-[25px] appearance-none items-center justify-center rounded-full text-violet11 hover:bg-violet4 focus:shadow-[0_0_0_2px] focus:shadow-violet7 focus:outline-none"
            aria-label="Close"
          >
            <MdClose />
          </button>
        </Dialog.Close>
      </Dialog.Content>
    </Dialog.Portal>
  </Dialog.Root>
);

