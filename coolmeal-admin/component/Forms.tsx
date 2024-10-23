import React, { FC } from "react";
import * as Form from "@radix-ui/react-form";
import * as Checkbox from "@radix-ui/react-checkbox";
import { CheckIcon } from "@radix-ui/react-icons";

interface FormTextFieldProps {
  label: string;
  name: string;
  type?: string;
  placeholder?: string;
  defaultValue?: string;
  required?: boolean;
}

export const FormTextField: React.FC<FormTextFieldProps> = ({
  label,
  name,
  type = "text",
  placeholder = "",
  defaultValue = '',
  required = false,
}) => (
  <Form.Field className="mb-2 mt-2" name={name}>
    <div className="flex items-baseline justify-between">
      <Form.Label className="text-[15px] font-medium leading-[35px] mb-2">
        {label}
      </Form.Label>
      {required && (
        <Form.Message
          className="text-[13px] opacity-80"
          match="valueMissing"
        >
          Please enter your {label.toLowerCase()}
        </Form.Message>
      )}
      {type === "email" && (
        <Form.Message
          className="text-[13px] opacity-80"
          match="typeMismatch"
        >
          Please provide a valid email
        </Form.Message>
      )}
    </div>
    <Form.Control asChild>
      <input
        type={type}
        className="block w-full p-2 text-gray-900 border border-gray-300 rounded-md bg-white text-base focus:ring-green-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-green-500 dark:focus:border-green-500"
        defaultValue={defaultValue}
        placeholder={placeholder}
      />
    </Form.Control>
  </Form.Field>
);

interface FormTextAreaFieldProps {
  label: string;
  name: string;
  placeholder?: string;
  required?: boolean;
}

export const FormTextAreaField: React.FC<FormTextAreaFieldProps> = ({
  label,
  name,
  placeholder = "",
  required = false,
}) => (
  <Form.Field className="mb-2.5 mt-5 grid" name={name}>
    <div className="flex items-baseline justify-between">
      <Form.Label className="text-[15px] font-medium leading-[35px] mb-2">
        {label}
      </Form.Label>
      {required && (
        <Form.Message
          className="text-[13px] text-white opacity-80"
          match="valueMissing"
        >
          Please enter your {label.toLowerCase()}
        </Form.Message>
      )}
    </div>
    <Form.Control asChild>
      <textarea
        rows={4}
        className="block w-full p-2 text-gray-900 border border-gray-300 rounded-md bg-white text-base focus:ring-green-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-green-500 dark:focus:border-green-500"
        placeholder={placeholder}
        required={required}
      />
    </Form.Control>
  </Form.Field>
);


import * as Select from "@radix-ui/react-select";

interface FormSelectFieldProps {
  label: string;
  name: string;
  options: { value: string; label: string; disabled?: boolean }[];
  placeholder?: string;
  required?: boolean;
}

export const FormSelectField: React.FC<FormSelectFieldProps> = ({
  label,
  name,
  options,
  placeholder = "Select an option",
  required = false,
}) => (
  <div className="mb-2.5 mt-5 grid">
    <div className="flex items-baseline justify-between">
      <label
        htmlFor={name}
        className="text-[15px] font-medium leading-[35px] mb-2"
      >
        {label}
      </label>
      {required && (
        <span className="text-[13px] text-white opacity-80">
          Please select your {label.toLowerCase()}
        </span>
      )}
    </div>

    <Select.Root>
      <Select.Trigger
        className="inline-flex items-center justify-between w-full p-2 border border-gray-300 rounded-md bg-white text-base text-gray-900 dark:bg-gray-700 dark:border-gray-600 dark:text-white focus:ring-green-500 dark:focus:ring-green-500 dark:focus:border-green-500"
        aria-label={label}
      >
        <Select.Value placeholder={placeholder} />
        <Select.Icon className="ml-2">▼</Select.Icon>
      </Select.Trigger>

      <Select.Portal>
        <Select.Content className="bg-white dark:bg-gray-700 rounded-md shadow-lg overflow-hidden">
          <Select.Viewport className="p-2">
            {options.map((group, index) => (
              <Select.Item
                key={index}
                value={group.value}
                disabled={group.disabled}
                className={`p-2 rounded-md cursor-pointer text-gray-900 dark:text-white hover:bg-gray-100 dark:hover:bg-gray-600 ${group.disabled ? "opacity-50 cursor-not-allowed" : ""
                  }`}
              >
                <Select.ItemText>{group.label}</Select.ItemText>
              </Select.Item>
            ))}
          </Select.Viewport>
        </Select.Content>
      </Select.Portal>
    </Select.Root>
  </div>
);


interface FormCheckboxFieldProps {
  label: string;
  name: string;
  defaultChecked?: boolean;
  required?: boolean;
}

export const FormCheckboxField: FC<FormCheckboxFieldProps> = ({
  label,
  name,
  defaultChecked = false,
  required = false,
}) => (
  <div className="mb-4 mt-4">
    <label className="flex items-center gap-2 text-[15px] font-medium">
      <Checkbox.Root
        name={name}
        defaultChecked={defaultChecked}
        required={required}
        className="w-6 h-6 border-2 border-gray-300 rounded-md bg-white dark:bg-gray-700 dark:border-gray-600 focus:ring-green-500 focus:outline-none focus:border-green-500"
      >
        <Checkbox.Indicator className="flex items-center justify-center">
          <CheckIcon className="w-5 h-5 text-green-500" />
        </Checkbox.Indicator>
      </Checkbox.Root>
      {label}
    </label>
  </div>
);

