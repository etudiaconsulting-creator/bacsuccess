import Header from '@/components/layout/Header'

export default function SubjectLoading() {
  return (
    <div className="flex min-h-screen flex-col bg-background">
      <Header />
      <main className="flex-1">
        <div className="mx-auto max-w-6xl px-4 sm:px-6 lg:px-8">
          <div className="py-4">
            <div className="h-4 w-48 animate-pulse rounded bg-gray-200" />
          </div>
          <div className="py-8">
            <div className="flex items-center gap-3">
              <div className="h-8 w-1.5 animate-pulse rounded-full bg-gray-200" />
              <div className="h-8 w-40 animate-pulse rounded bg-gray-200" />
            </div>
            <div className="mt-3 h-4 w-36 animate-pulse rounded bg-gray-200" />
          </div>
          <div className="flex flex-col gap-4 pb-12">
            {Array.from({ length: 5 }).map((_, i) => (
              <div key={i} className="flex items-start gap-4 rounded-xl border border-gray-200 bg-white p-6 shadow-sm">
                <div className="h-10 w-10 flex-shrink-0 animate-pulse rounded-lg bg-gray-200" />
                <div className="flex-1">
                  <div className="h-5 w-48 animate-pulse rounded bg-gray-200" />
                  <div className="mt-2 h-4 w-full animate-pulse rounded bg-gray-200" />
                  <div className="mt-2 h-3 w-16 animate-pulse rounded bg-gray-200" />
                </div>
                <div className="h-5 w-5 flex-shrink-0 animate-pulse rounded bg-gray-200" />
              </div>
            ))}
          </div>
        </div>
      </main>
    </div>
  )
}
