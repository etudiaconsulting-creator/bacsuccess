import Header from '@/components/layout/Header'

export default function ChapterLoading() {
  return (
    <div className="flex min-h-screen flex-col bg-background">
      <Header />
      <main className="flex-1">
        <div className="mx-auto max-w-6xl px-4 sm:px-6 lg:px-8">
          <div className="py-4">
            <div className="h-4 w-56 animate-pulse rounded bg-gray-200" />
          </div>
          <div className="py-8">
            <div className="h-8 w-72 animate-pulse rounded bg-gray-200" />
            <div className="mt-3 h-4 w-full max-w-md animate-pulse rounded bg-gray-200" />
          </div>
          <div className="grid grid-cols-1 gap-4 pb-12 sm:grid-cols-2 lg:grid-cols-3">
            {Array.from({ length: 4 }).map((_, i) => (
              <div key={i} className="rounded-xl border border-gray-200 bg-white p-6 shadow-sm">
                <div className="flex items-start justify-between gap-2">
                  <div className="h-5 w-36 animate-pulse rounded bg-gray-200" />
                  <div className="h-5 w-16 animate-pulse rounded-full bg-gray-200" />
                </div>
                <div className="mt-3 h-4 w-full animate-pulse rounded bg-gray-200" />
              </div>
            ))}
          </div>
        </div>
      </main>
    </div>
  )
}
