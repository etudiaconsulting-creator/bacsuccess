'use client'

interface ProgressBarProps {
  viewed: number
  total: number
  color?: string
  avgScore?: number | null
}

export default function ProgressBar({ viewed, total, color = '#1B4332', avgScore }: ProgressBarProps) {
  if (total === 0) return null

  const percentage = Math.round((viewed / total) * 100)

  return (
    <div className="mt-3">
      <div className="flex items-center justify-between text-xs text-muted mb-1">
        <span>
          {viewed}/{total} fiche{total > 1 ? 's' : ''} vue{viewed > 1 ? 's' : ''}
        </span>
        <span className="flex items-center gap-2">
          {avgScore != null && (
            <span className="font-medium" style={{ color }}>
              Quiz: {avgScore}%
            </span>
          )}
          <span className="font-semibold">{percentage}%</span>
        </span>
      </div>
      <div className="h-1.5 w-full rounded-full bg-gray-200 overflow-hidden">
        <div
          className="h-full rounded-full transition-all duration-500 ease-out"
          style={{
            width: `${percentage}%`,
            backgroundColor: color,
          }}
        />
      </div>
    </div>
  )
}
