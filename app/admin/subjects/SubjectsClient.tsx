'use client'

import { useState } from 'react'
import { useRouter } from 'next/navigation'
import AdminTable from '@/components/admin/AdminTable'
import AdminModal from '@/components/admin/AdminModal'
import { createClient } from '@/lib/supabase/client'

interface SubjectRow {
  id: string
  series_id: string
  slug: string
  name: string
  coefficient: number
  hours_per_week: number | null
  color: string | null
  icon: string | null
  display_order: number
  created_at: string
  series: { short_name: string; countries: { name: string } | null } | null
}

interface Props {
  subjects: SubjectRow[]
  series: { id: string; short_name: string; countries: { name: string } | null }[]
}

export default function SubjectsClient({ subjects, series }: Props) {
  const router = useRouter()
  const [modalOpen, setModalOpen] = useState(false)
  const [editing, setEditing] = useState<SubjectRow | null>(null)
  const [form, setForm] = useState({
    name: '', slug: '', series_id: '', coefficient: 1, color: '', icon: '', display_order: 0,
  })
  const [saving, setSaving] = useState(false)

  function openCreate() {
    setEditing(null)
    setForm({ name: '', slug: '', series_id: series[0]?.id ?? '', coefficient: 1, color: '', icon: '', display_order: 0 })
    setModalOpen(true)
  }

  function openEdit(item: SubjectRow) {
    setEditing(item)
    setForm({
      name: item.name, slug: item.slug, series_id: item.series_id,
      coefficient: item.coefficient, color: item.color ?? '', icon: item.icon ?? '',
      display_order: item.display_order,
    })
    setModalOpen(true)
  }

  async function handleSave(e: React.FormEvent) {
    e.preventDefault()
    setSaving(true)
    const supabase = createClient()

    const payload = {
      name: form.name, slug: form.slug, series_id: form.series_id,
      coefficient: form.coefficient, color: form.color || null, icon: form.icon || null,
      display_order: form.display_order,
    }

    if (editing) {
      await supabase.from('subjects').update(payload).eq('id', editing.id)
    } else {
      await supabase.from('subjects').insert(payload)
    }

    setSaving(false)
    setModalOpen(false)
    router.refresh()
  }

  async function handleDelete(id: string) {
    const supabase = createClient()
    await supabase.from('subjects').delete().eq('id', id)
    router.refresh()
  }

  return (
    <>
      <AdminTable
        title="Matières"
        data={subjects}
        columns={[
          { key: 'name', label: 'Nom' },
          { key: 'slug', label: 'Slug' },
          { key: 'coefficient', label: 'Coef.' },
          { key: 'color', label: 'Couleur', render: (s) => s.color ? (
            <span className="flex items-center gap-2">
              <span className="w-3 h-3 rounded-full" style={{ backgroundColor: s.color }} />
              {s.color}
            </span>
          ) : '—' },
          { key: 'series', label: 'Série', render: (s) => s.series ? `${s.series.short_name} (${s.series.countries?.name ?? ''})` : '—' },
        ]}
        getId={(s) => s.id}
        onEdit={openEdit}
        onDelete={handleDelete}
        onCreate={openCreate}
        searchField="name"
      />

      <AdminModal
        title={editing ? 'Modifier la matière' : 'Nouvelle matière'}
        isOpen={modalOpen}
        onClose={() => setModalOpen(false)}
      >
        <form onSubmit={handleSave} className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-foreground mb-1">Série</label>
            <select value={form.series_id} onChange={(e) => setForm({ ...form, series_id: e.target.value })} className="w-full rounded-lg border border-gray-200 px-4 py-2.5 text-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:bg-gray-700 dark:border-gray-600">
              {series.map((s) => (
                <option key={s.id} value={s.id}>{s.short_name} ({s.countries?.name ?? ''})</option>
              ))}
            </select>
          </div>
          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="block text-sm font-medium text-foreground mb-1">Nom</label>
              <input type="text" required value={form.name} onChange={(e) => setForm({ ...form, name: e.target.value })} className="w-full rounded-lg border border-gray-200 px-4 py-2.5 text-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:bg-gray-700 dark:border-gray-600" />
            </div>
            <div>
              <label className="block text-sm font-medium text-foreground mb-1">Slug</label>
              <input type="text" required value={form.slug} onChange={(e) => setForm({ ...form, slug: e.target.value })} className="w-full rounded-lg border border-gray-200 px-4 py-2.5 text-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:bg-gray-700 dark:border-gray-600" />
            </div>
          </div>
          <div className="grid grid-cols-3 gap-4">
            <div>
              <label className="block text-sm font-medium text-foreground mb-1">Coefficient</label>
              <input type="number" required min={1} value={form.coefficient} onChange={(e) => setForm({ ...form, coefficient: Number(e.target.value) })} className="w-full rounded-lg border border-gray-200 px-4 py-2.5 text-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:bg-gray-700 dark:border-gray-600" />
            </div>
            <div>
              <label className="block text-sm font-medium text-foreground mb-1">Couleur</label>
              <input type="text" value={form.color} onChange={(e) => setForm({ ...form, color: e.target.value })} placeholder="eco" className="w-full rounded-lg border border-gray-200 px-4 py-2.5 text-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:bg-gray-700 dark:border-gray-600" />
            </div>
            <div>
              <label className="block text-sm font-medium text-foreground mb-1">Ordre</label>
              <input type="number" value={form.display_order} onChange={(e) => setForm({ ...form, display_order: Number(e.target.value) })} className="w-full rounded-lg border border-gray-200 px-4 py-2.5 text-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:bg-gray-700 dark:border-gray-600" />
            </div>
          </div>
          <div>
            <label className="block text-sm font-medium text-foreground mb-1">Icône</label>
            <input type="text" value={form.icon} onChange={(e) => setForm({ ...form, icon: e.target.value })} placeholder="TrendingUp" className="w-full rounded-lg border border-gray-200 px-4 py-2.5 text-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:bg-gray-700 dark:border-gray-600" />
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
