'use client'

import Image from 'next/image'

interface TeamPhotoProps {
  name: string
  initials: string
  photo: string
}

export default function TeamPhoto({ name, initials, photo }: TeamPhotoProps) {
  return (
    <div className="relative mx-auto h-32 w-32 overflow-hidden rounded-full border-4 border-white shadow-lg">
      <Image
        src={photo}
        alt={name}
        fill
        className="object-cover"
        onError={(e) => {
          ;(e.target as HTMLImageElement).style.display = 'none'
        }}
      />
      {/* Fallback initials — visible when image fails to load */}
      <div className="absolute inset-0 flex items-center justify-center bg-primary text-2xl font-bold text-white">
        {initials}
      </div>
    </div>
  )
}
