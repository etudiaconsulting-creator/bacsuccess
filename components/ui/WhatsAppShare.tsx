'use client'

import { MessageCircle } from 'lucide-react'

interface WhatsAppShareProps {
  message: string
}

export default function WhatsAppShare({ message }: WhatsAppShareProps) {
  const url = `https://wa.me/?text=${encodeURIComponent(message)}`

  return (
    <a
      href={url}
      target="_blank"
      rel="noopener noreferrer"
      className="inline-flex items-center gap-2 rounded-xl px-5 py-2.5 text-sm font-semibold text-white transition-colors hover:opacity-90"
      style={{ backgroundColor: '#25D366' }}
    >
      <MessageCircle className="h-4 w-4" />
      Partager sur WhatsApp
    </a>
  )
}
