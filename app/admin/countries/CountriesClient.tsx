'use client'

import { useState } from 'react'
import { useRouter } from 'next/navigation'
import AdminTable from '@/components/admin/AdminTable'
import AdminModal from '@/components/admin/AdminModal'
import { createClient } from '@/lib/supabase/client'
import type { Country } from '@/lib/supabase/types'

interface Props {
  countries: Country[]
}

export default function CountriesClient({ countries }: Props) {
  const router = useRouter()
  const [modalOpen, setModalOpen] = useState(false)
  const [editing, setEditing] = useState<Country | null>(null)
  const [form, setForm] = useState({ name: '', slug: '', flag_emoji: '', is_active: true })
  const [saving, setSaving] = useState(false)

  function openCreate() {
    setEditing(null)
    setForm({ name: '', slug: '', flag_emoji: '', is_active: true })
    setModalOpen(true)
  }

  function openEdit(item: Country) {
    setEditing(item)
    setForm({
      name: item.name,
      slug: item.slug,
      flag_emoji: item.flag_emoji ?? '',
      is_active: item.is_active,
    })
    setModalOpen(true)
  }

  async function handleSave(e: React.FormEvent) {
    e.preventDefault()
    setSaving(true)
    const supabase = createClient()

    if (editing) {
      await supabase
        .from('countries')
        .update({
          name: form.name,
          slug: form.slug,
          flag_emoji: form.flag_emoji || null,
          is_active: form.is_active,
        })
        .eq('id', editing.id)
    } else {
      await supabase.from('countries').insert({
        name: form.name,
        slug: form.slug,
        flag_emoji: form.flag_emoji || null,
        is_active: form.is_active,
      })
    }

    setSaving(false)
    setModalOpen(false)
    router.refresh()
  }

  async function handleDelete(id: string) {
    const supabase = createClient()
    await supabase.from('countries').delete().eq('id', id)
    router.refresh()
  }

  return (
    <>
      <AdminTable
        title="Pays"
        data={countries}
        columns={[
          { key: 'flag_emoji', label: 'Drapeau', render: (c) => c.flag_emoji ?? '—' },
          { key: 'name', label: 'Nom' },
          { key: 'slug', label: 'Slug' },
          {
            key: 'is_active',
            label: 'Actif',
            render: (c) => (
              <span className={`inline-block rounded-full px-2 py-0.5 text-xs font-medium ${c.is_active ? 'bg-green-100 text-green-800' : 'bg-gray-100 text-gray-500'}`}>
                {c.is_active ? 'Oui' : 'Non'}
              </span>
            ),
          },
        ]}
        getId={(c) => c.id}
        onEdit={openEdit}
        onDelete={handleDelete}
        onCreate={openCreate}
        searchField="name"
      />

      <AdminModal
        title={editing ? 'Modifier le pays' : 'Nouveau pays'}
        isOpen={modalOpen}
        onClose={() => setModalOpen(false)}
      >
        <form onSubmit={handleSave} className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-foreground mb-1">Nom</label>
            <input
              type="text"
              required
              value={form.name}
              onChange={(e) => setForm({ ...form, name: e.target.value })}
              className="w-full rounded-lg border border-gray-200 px-4 py-2.5 text-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:bg-gray-700 dark:border-gray-600"
            />
          </div>
          <div>
            <label className="block text-sm font-medium text-foreground mb-1">Slug</label>
            <input
              type="text"
              required
              value={form.slug}
              onChange={(e) => setForm({ ...form, slug: e.target.value })}
              className="w-full rounded-lg border border-gray-200 px-4 py-2.5 text-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:bg-gray-700 dark:border-gray-600"
            />
          </div>
          <div>
            <label className="block text-sm font-medium text-foreground mb-1">Emoji drapeau</label>
            <input
              type="text"
              value={form.flag_emoji}
              onChange={(e) => setForm({ ...form, flag_emoji: e.target.value })}
              className="w-full rounded-lg border border-gray-200 px-4 py-2.5 text-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:bg-gray-700 dark:border-gray-600"
              placeholder="🇲🇱"
            />
          </div>
          <div className="flex items-center gap-2">
            <input
              type="checkbox"
              id="is_active"
              checked={form.is_active}
              onChange={(e) => setForm({ ...form, is_active: e.target.checked })}
              className="rounded accent-primary"
            />
            <label htmlFor="is_active" className="text-sm text-foreground">Actif</label>
          </div>
          <div className="flex justify-end gap-3 pt-2">
            <button
              type="button"
              onClick={() => setModalOpen(false)}
              className="px-4 py-2.5 rounded-lg text-sm font-medium text-muted hover:bg-gray-100 transition-colors cursor-pointer dark:hover:bg-gray-700"
            >
              Annuler
            </button>
            <button
              type="submit"
              disabled={saving}
              className="px-6 py-2.5 rounded-lg bg-primary text-sm font-semibold text-white hover:bg-primary-light transition-colors cursor-pointer disabled:opacity-50"
            >
              {saving ? 'Enregistrement...' : editing ? 'Enregistrer' : 'Créer'}
            </button>
          </div>
        </form>
      </AdminModal>
    </>
  )
}
