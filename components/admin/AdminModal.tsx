'use client'

import { X } from 'lucide-react'
import { useEffect } from 'react'

interface AdminModalProps {
  title: string
  isOpen: boolean
  onClose: () => void
  children: React.ReactNode
}

export default function AdminModal({ title, isOpen, onClose, children }: AdminModalProps) {
  useEffect(() => {
    if (isOpen) {
      document.body.style.overflow = 'hidden'
    }
    return () => {
      document.body.style.overflow = ''
    }
  }, [isOpen])

  if (!isOpen) return null

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      <div className="fixed inset-0 bg-black/50" onClick={onClose} />
      <div className="relative z-10 w-full max-w-lg max-h-[90vh] overflow-y-auto rounded-2xl bg-white p-8 shadow-2xl dark:bg-gray-800">
        <div className="flex items-center justify-between mb-6">
          <h2 className="font-serif text-xl font-bold text-foreground">{title}</h2>
          <button
            onClick={onClose}
            className="rounded-lg p-2 text-muted hover:bg-gray-100 transition-colors cursor-pointer dark:hover:bg-gray-700"
          >
            <X className="h-5 w-5" />
          </button>
        </div>
        {children}
      </div>
    </div>
  )
}
