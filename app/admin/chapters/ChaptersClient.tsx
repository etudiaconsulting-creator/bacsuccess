'use client'

import { useState } from 'react'
import { useRouter } from 'next/navigation'
import AdminTable from '@/components/admin/AdminTable'
import AdminModal from '@/components/admin/AdminModal'
import { createClient } from '@/lib/supabase/client'

interface ChapterRow {
  id: string
  subject_id: string
  slug: string
  number: number
  title: string
  description: string | null
  display_order: number
  created_at: string
  subjects: { name: string } | null
}

interface Props {
  chapters: ChapterRow[]
  subjects: { id: string; name: string }[]
}

export default function ChaptersClient({ chapters, subjects }: Props) {
  const router = useRouter()
  const [modalOpen, setModalOpen] = useState(false)
  const [editing, setEditing] = useState<ChapterRow | null>(null)
  const [form, setForm] = useState({
    title: '', slug: '', subject_id: '', number: 1, description: '', display_order: 0,
  })
  const [saving, setSaving] = useState(false)

  function openCreate() {
    setEditing(null)
    setForm({ title: '', slug: '', subject_id: subjects[0]?.id ?? '', number: 1, description: '', display_order: 0 })
    setModalOpen(true)
  }

  function openEdit(item: ChapterRow) {
    setEditing(item)
    setForm({
      title: item.title, slug: item.slug, subject_id: item.subject_id,
      number: item.number, description: item.description ?? '', display_order: item.display_order,
    })
    setModalOpen(true)
  }

  async function handleSave(e: React.FormEvent) {
    e.preventDefault()
    setSaving(true)
    const supabase = createClient()

    const payload = {
      title: form.title, slug: form.slug, subject_id: form.subject_id,
      number: form.number, description: form.description || null, display_order: form.display_order,
    }

    if (editing) {
      await supabase.from('chapters').update(payload).eq('id', editing.id)
    } else {
      await supabase.from('chapters').insert(payload)
    }

    setSaving(false)
    setModalOpen(false)
    router.refresh()
  }

  async function handleDelete(id: string) {
    const supabase = createClient()
    await supabase.from('chapters').delete().eq('id', id)
    router.refresh()
  }

  return (
    <>
      <AdminTable
        title="Chapitres"
        data={chapters}
        columns={[
          { key: 'number', label: '#' },
          { key: 'title', label: 'Titre' },
          { key: 'slug', label: 'Slug' },
          { key: 'subjects', label: 'Matière', render: (c) => c.subjects?.name ?? '—' },
          { key: 'display_order', label: 'Ordre' },
        ]}
        getId={(c) => c.id}
        onEdit={openEdit}
        onDelete={handleDelete}
        onCreate={openCreate}
        searchField="title"
      />

      <AdminModal
        title={editing ? 'Modifier le chapitre' : 'Nouveau chapitre'}
        isOpen={modalOpen}
        onClose={() => setModalOpen(false)}
      >
        <form onSubmit={handleSave} className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-foreground mb-1">Matière</label>
            <select value={form.subject_id} onChange={(e) => setForm({ ...form, subject_id: e.target.value })} className="w-full rounded-lg border border-gray-200 px-4 py-2.5 text-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:bg-gray-700 dark:border-gray-600">
              {subjects.map((s) => (
                <option key={s.id} value={s.id}>{s.name}</option>
              ))}
            </select>
          </div>
          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="block text-sm font-medium text-foreground mb-1">Titre</label>
              <input type="text" required value={form.title} onChange={(e) => setForm({ ...form, title: e.target.value })} className="w-full rounded-lg border border-gray-200 px-4 py-2.5 text-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:bg-gray-700 dark:border-gray-600" />
            </div>
            <div>
              <label className="block text-sm font-medium text-foreground mb-1">Slug</label>
              <input type="text" required value={form.slug} onChange={(e) => setForm({ ...form, slug: e.target.value })} className="w-full rounded-lg border border-gray-200 px-4 py-2.5 text-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:bg-gray-700 dark:border-gray-600" />
            </div>
          </div>
          <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="block text-sm font-medium text-foreground mb-1">Numéro</label>
              <input type="number" required min={1} value={form.number} onChange={(e) => setForm({ ...form, number: Number(e.target.value) })} className="w-full rounded-lg border border-gray-200 px-4 py-2.5 text-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:bg-gray-700 dark:border-gray-600" />
            </div>
            <div>
              <label className="block text-sm font-medium text-foreground mb-1">Ordre d&apos;affichage</label>
              <input type="number" value={form.display_order} onChange={(e) => setForm({ ...form, display_order: Number(e.target.value) })} className="w-full rounded-lg border border-gray-200 px-4 py-2.5 text-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:bg-gray-700 dark:border-gray-600" />
            </div>
          </div>
          <div>
            <label className="block text-sm font-medium text-foreground mb-1">Description</label>
            <textarea value={form.description} onChange={(e) => setForm({ ...form, description: e.target.value })} rows={2} className="w-full rounded-lg border border-gray-200 px-4 py-2.5 text-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:bg-gray-700 dark:border-gray-600" />
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
