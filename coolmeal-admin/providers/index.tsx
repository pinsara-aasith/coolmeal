"use client";

import { ReactNode } from 'react'
import { SnackbarProvider } from 'notistack'

const AllProviders = ({ children }: { children: ReactNode }) => {
  return <SnackbarProvider>
      {children}
    </SnackbarProvider>
}

export default AllProviders
