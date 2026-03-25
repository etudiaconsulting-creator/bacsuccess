import Header from '@/components/layout/AuthHeader'

export default function SeriesLoading() {
  return (
    <div className="flex min-h-screen flex-col bg-background">
      <Header />
      <main className="flex-1">
        <div className="mx-auto max-w-6xl px-4 sm:px-6 lg:px-8">
          <div className="py-4">
            <div className="h-4 w-32 animate-pulse rounded bg-gray-200" />
          </div>
          <div className="py-8">
            <div className="h-8 w-56 animate-pulse rounded bg-gray-200" />
            <div className="mt-3 h-4 w-40 animate-pulse rounded bg-gray-200" />
          </div>
          <div className="grid grid-cols-1 gap-4 pb-12 sm:grid-cols-2 lg:grid-cols-3">
            {Array.from({ length: 6 }).map((_, i) => (
              <div
                key={i}
                className="rounded-xl border border-gray-200 bg-white shadow-sm"
                style={{ borderLeftWidth: '4px', borderLeftColor: '#E5E7EB' }}
              >
                <div className="p-6">
                  <div className="flex items-start justify-between">
                    <div className="h-10 w-10 animate-pulse rounded-lg bg-gray-200" />
                    <div className="h-5 w-16 animate-pulse rounded-full bg-gray-200" />
                  </div>
                  <div className="mt-4 h-5 w-32 animate-pulse rounded bg-gray-200" />
                  <div className="mt-3 flex items-center gap-4">
                    <div className="h-3 w-20 animate-pulse rounded bg-gray-200" />
                    <div className="h-3 w-16 animate-pulse rounded bg-gray-200" />
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>
      </main>
    </div>
  )
}
