'use client'

import { useState } from 'react'
import { useRouter } from 'next/navigation'
import AdminTable from '@/components/admin/AdminTable'
import AdminModal from '@/components/admin/AdminModal'
import { createClient } from '@/lib/supabase/client'

interface SeriesRow {
  id: string
  country_id: string
  slug: string
  name: string
  short_name: string
  description: string | null
  is_active: boolean
  created_at: string
  countries: { name: string } | null
}

interface Props {
  series: SeriesRow[]
  countries: { id: string; name: string }[]
}

export default function SeriesClient({ series, countries }: Props) {
  const router = useRouter()
  const [modalOpen, setModalOpen] = useState(false)
  const [editing, setEditing] = useState<SeriesRow | null>(null)
  const [form, setForm] = useState({
    name: '', short_name: '', slug: '', country_id: '', description: '', is_active: true,
  })
  const [saving, setSaving] = useState(false)

  function openCreate() {
    setEditing(null)
    setForm({ name: '', short_name: '', slug: '', country_id: countries[0]?.id ?? '', description: '', is_active: true })
    setModalOpen(true)
  }

  function openEdit(item: SeriesRow) {
    setEditing(item)
    setForm({
      name: item.name,
      short_name: item.short_name,
      slug: item.slug,
      country_id: item.country_id,
      description: item.description ?? '',
      is_active: item.is_active,
    })
    setModalOpen(true)
  }

  async function handleSave(e: React.FormEvent) {
    e.preventDefault()
    setSaving(true)
    const supabase = createClient()

    const payload = {
      name: form.name,
      short_name: form.short_name,
      slug: form.slug,
      country_id: form.country_id,
      description: form.description || null,
      is_active: form.is_active,
    }

    if (editing) {
      await supabase.from('series').update(payload).eq('id', editing.id)
    } else {
      await supabase.from('series').insert(payload)
    }

    setSaving(false)
    setModalOpen(false)
    router.refresh()
  }

  async function handleDelete(id: string) {
    const supabase = createClient()
    await supabase.from('series').delete().eq('id', id)
    router.refresh()
  }

  return (
    <>
      <AdminTable
        title="Séries"
        data={series}
        columns={[
          { key: 'short_name', label: 'Abrégé' },
          { key: 'name', label: 'Nom' },
          { key: 'slug', label: 'Slug' },
          { key: 'countries', label: 'Pays', render: (s) => s.countries?.name ?? '—' },
          {
            key: 'is_active',
            label: 'Actif',
            render: (s) => (
              <span className={`inline-block rounded-full px-2 py-0.5 text-xs font-medium ${s.is_active ? 'bg-green-100 text-green-800' : 'bg-gray-100 text-gray-500'}`}>
                {s.is_active ? 'Oui' : 'Non'}
              </span>
            ),
          },
        ]}
        getId={(s) => s.id}
        onEdit={openEdit}
        onDelete={handleDelete}
        onCreate={openCreate}
        searchField="name"
      />

      <AdminModal
        title={editing ? 'Modifier la série' : 'Nouvelle série'}
        isOpen={modalOpen}
        onClose={() => setModalOpen(false)}
      >
        <form onSubmit={handleSave} className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-foreground mb-1">Pays</label>
            <select
              value={form.country_id}
              onChange={(e) => setForm({ ...form, country_id: e.target.value })}
              className="w-full rounded-lg border border-gray-200 px-4 py-2.5 text-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:bg-gray-700 dark:border-gray-600"
            >
              {countries.map((c) => (
                <option key={c.id} value={c.id}>{c.name}</option>
              ))}
            </select>
          </div>
          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="block text-sm font-medium text-foreground mb-1">Nom</label>
              <input type="text" required value={form.name} onChange={(e) => setForm({ ...form, name: e.target.value })} className="w-full rounded-lg border border-gray-200 px-4 py-2.5 text-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:bg-gray-700 dark:border-gray-600" />
            </div>
            <div>
              <label className="block text-sm font-medium text-foreground mb-1">Abrégé</label>
              <input type="text" required value={form.short_name} onChange={(e) => setForm({ ...form, short_name: e.target.value })} className="w-full rounded-lg border border-gray-200 px-4 py-2.5 text-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:bg-gray-700 dark:border-gray-600" />
            </div>
          </div>
          <div>
            <label className="block text-sm font-medium text-foreground mb-1">Slug</label>
            <input type="text" required value={form.slug} onChange={(e) => setForm({ ...form, slug: e.target.value })} className="w-full rounded-lg border border-gray-200 px-4 py-2.5 text-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:bg-gray-700 dark:border-gray-600" />
          </div>
          <div>
            <label className="block text-sm font-medium text-foreground mb-1">Description</label>
            <textarea value={form.description} onChange={(e) => setForm({ ...form, description: e.target.value })} rows={2} className="w-full rounded-lg border border-gray-200 px-4 py-2.5 text-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:bg-gray-700 dark:border-gray-600" />
          </div>
          <div className="flex items-center gap-2">
            <input type="checkbox" id="is_active" checked={form.is_active} onChange={(e) => setForm({ ...form, is_active: e.target.checked })} className="rounded accent-primary" />
            <label htmlFor="is_active" className="text-sm text-foreground">Actif</label>
          </div>
          <div className="flex justify-end gap-3 pt-2">
            <button type="button" onClick={() => setModalOpen(false)} className="px-4 py-2.5 rounded-lg text-sm font-medium text-muted hover:bg-gray-100 transition-colors cursor-pointer dark:hover:bg-gray-700">Annuler</button>
            <button type="submit" disabled={saving} className="px-6 py-2.5 rounded-lg bg-primary text-sm font-semibold text-white hover:bg-primary-light transition-colors cursor-pointer disabled:opacity-50">
              {saving ? 'Enregistrement...' : editing ? 'Enregistrer' : 'Créer'}
            </button>
          </div>
        </form>
      </AdminModal>
    </>
  )
}
