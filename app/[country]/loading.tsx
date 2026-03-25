import Header from '@/components/layout/AuthHeader'

export default function CountryLoading() {
  return (
    <div className="flex min-h-screen flex-col bg-background">
      <Header />
      <main className="flex-1">
        <div className="mx-auto max-w-6xl px-4 sm:px-6 lg:px-8">
          <div className="py-4">
            <div className="h-4 w-24 animate-pulse rounded bg-gray-200" />
          </div>
          <div className="py-8">
            <div className="h-8 w-64 animate-pulse rounded bg-gray-200" />
            <div className="mt-3 h-4 w-48 animate-pulse rounded bg-gray-200" />
          </div>
          <div className="grid grid-cols-1 gap-4 pb-12 sm:grid-cols-2 lg:grid-cols-3">
            {Array.from({ length: 3 }).map((_, i) => (
              <div key={i} className="rounded-xl border border-gray-200 bg-white p-6 shadow-sm">
                <div className="flex items-center justify-between">
                  <div className="h-6 w-20 animate-pulse rounded bg-gray-200" />
                  <div className="h-5 w-5 animate-pulse rounded bg-gray-200" />
                </div>
                <div className="mt-3 h-4 w-full animate-pulse rounded bg-gray-200" />
                <div className="mt-2 h-3 w-3/4 animate-pulse rounded bg-gray-200" />
              </div>
            ))}
          </div>
        </div>
      </main>
    </div>
  )
}
