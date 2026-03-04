'use client'

import { useState } from 'react'
import { Trash2, Edit2, Plus, Search } from 'lucide-react'

interface Column<T> {
  key: string
  label: string
  render?: (item: T) => React.ReactNode
}

interface AdminTableProps<T> {
  title: string
  data: T[]
  columns: Column<T>[]
  getId: (item: T) => string
  onDelete?: (id: string) => Promise<void>
  onEdit?: (item: T) => void
  onCreate?: () => void
  searchField?: string
}

// eslint-disable-next-line @typescript-eslint/no-explicit-any
export default function AdminTable<T extends Record<string, any>>({
  title,
  data,
  columns,
  getId,
  onDelete,
  onEdit,
  onCreate,
  searchField,
}: AdminTableProps<T>) {
  const [search, setSearch] = useState('')
  const [deleting, setDeleting] = useState<string | null>(null)

  const filteredData = searchField && search
    ? data.filter((item) => {
        const val = item[searchField]
        return typeof val === 'string' && val.toLowerCase().includes(search.toLowerCase())
      })
    : data

  async function handleDelete(id: string) {
    if (!onDelete) return
    if (!confirm('Êtes-vous sûr de vouloir supprimer cet élément ?')) return
    setDeleting(id)
    try {
      await onDelete(id)
    } finally {
      setDeleting(null)
    }
  }

  return (
    <div>
      <div className="flex items-center justify-between mb-6">
        <div>
          <h1 className="font-serif text-2xl font-bold text-foreground">{title}</h1>
          <p className="text-sm text-muted mt-1">{filteredData.length} élément{filteredData.length !== 1 ? 's' : ''}</p>
        </div>
        {onCreate && (
          <button
            onClick={onCreate}
            className="inline-flex items-center gap-2 rounded-xl bg-primary px-4 py-2.5 text-sm font-semibold text-white hover:bg-primary-light transition-colors cursor-pointer"
          >
            <Plus className="h-4 w-4" />
            Ajouter
          </button>
        )}
      </div>

      {searchField && (
        <div className="relative mb-4">
          <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted" />
          <input
            type="text"
            placeholder="Rechercher..."
            value={search}
            onChange={(e) => setSearch(e.target.value)}
            className="w-full rounded-lg border border-gray-200 bg-white pl-10 pr-4 py-2.5 text-sm text-foreground placeholder:text-muted focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:bg-gray-800 dark:border-gray-700"
          />
        </div>
      )}

      <div className="overflow-x-auto rounded-xl border border-gray-200 bg-white shadow-sm dark:bg-gray-800 dark:border-gray-700">
        <table className="w-full text-left text-sm">
          <thead className="border-b border-gray-200 bg-gray-50 dark:bg-gray-700 dark:border-gray-600">
            <tr>
              {columns.map((col) => (
                <th key={col.key} className="px-4 py-3 font-semibold text-muted">
                  {col.label}
                </th>
              ))}
              {(onEdit || onDelete) && (
                <th className="px-4 py-3 font-semibold text-muted text-right">Actions</th>
              )}
            </tr>
          </thead>
          <tbody className="divide-y divide-gray-200 dark:divide-gray-700">
            {filteredData.map((item) => (
              <tr key={getId(item)} className="hover:bg-gray-50 dark:hover:bg-gray-700/50">
                {columns.map((col) => (
                  <td key={col.key} className="px-4 py-3 text-foreground">
                    {col.render ? col.render(item) : String(item[col.key] ?? '')}
                  </td>
                ))}
                {(onEdit || onDelete) && (
                  <td className="px-4 py-3 text-right">
                    <div className="inline-flex items-center gap-1">
                      {onEdit && (
                        <button
                          onClick={() => onEdit(item)}
                          className="rounded-lg p-2 text-muted hover:bg-gray-100 hover:text-foreground transition-colors cursor-pointer dark:hover:bg-gray-600"
                          title="Modifier"
                        >
                          <Edit2 className="h-4 w-4" />
                        </button>
                      )}
                      {onDelete && (
                        <button
                          onClick={() => handleDelete(getId(item))}
                          disabled={deleting === getId(item)}
                          className="rounded-lg p-2 text-muted hover:bg-red-50 hover:text-red-600 transition-colors cursor-pointer disabled:opacity-50 dark:hover:bg-red-900/30"
                          title="Supprimer"
                        >
                          <Trash2 className="h-4 w-4" />
                        </button>
                      )}
                    </div>
                  </td>
                )}
              </tr>
            ))}
            {filteredData.length === 0 && (
              <tr>
                <td
                  colSpan={columns.length + (onEdit || onDelete ? 1 : 0)}
                  className="px-4 py-12 text-center text-muted"
                >
                  Aucun élément trouvé
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>
    </div>
  )
}
