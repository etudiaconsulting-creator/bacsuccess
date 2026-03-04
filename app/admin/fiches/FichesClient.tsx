'use client'

import { useState } from 'react'
import { useRouter } from 'next/navigation'
import AdminTable from '@/components/admin/AdminTable'
import AdminModal from '@/components/admin/AdminModal'
import { createClient } from '@/lib/supabase/client'

interface FicheRow {
  id: string
  chapter_id: string
  slug: string
  title: string
  subtitle: string | null
  content: Record<string, unknown>
  is_free: boolean
  is_published: boolean
  display_order: number
  created_at: string
  updated_at: string
  chapters: { title: string; number: number; subjects: { name: string } | null } | null
}

interface Props {
  fiches: FicheRow[]
  chapters: { id: string; title: string; number: number; subjects: { name: string } | null }[]
}

export default function FichesClient({ fiches, chapters }: Props) {
  const router = useRouter()
  const [modalOpen, setModalOpen] = useState(false)
  const [editing, setEditing] = useState<FicheRow | null>(null)
  const [form, setForm] = useState({
    title: '', slug: '', subtitle: '', chapter_id: '', is_free: true, is_published: true,
    display_order: 0, content: '{\n  "flashcards": [],\n  "schema": { "title": "", "nodes": [], "edges": [] },\n  "quiz": []\n}',
  })
  const [saving, setSaving] = useState(false)
  const [jsonError, setJsonError] = useState('')

  function openCreate() {
    setEditing(null)
    setForm({
      title: '', slug: '', subtitle: '', chapter_id: chapters[0]?.id ?? '',
      is_free: true, is_published: true, display_order: 0,
      content: '{\n  "flashcards": [],\n  "schema": { "title": "", "nodes": [], "edges": [] },\n  "quiz": []\n}',
    })
    setJsonError('')
    setModalOpen(true)
  }

  function openEdit(item: FicheRow) {
    setEditing(item)
    setForm({
      title: item.title, slug: item.slug, subtitle: item.subtitle ?? '',
      chapter_id: item.chapter_id, is_free: item.is_free, is_published: item.is_published,
      display_order: item.display_order,
      content: JSON.stringify(item.content, null, 2),
    })
    setJsonError('')
    setModalOpen(true)
  }

  async function handleSave(e: React.FormEvent) {
    e.preventDefault()

    let contentObj
    try {
      contentObj = JSON.parse(form.content)
      setJsonError('')
    } catch {
      setJsonError('JSON invalide. Vérifiez le contenu.')
      return
    }

    setSaving(true)
    const supabase = createClient()

    const payload = {
      title: form.title, slug: form.slug, subtitle: form.subtitle || null,
      chapter_id: form.chapter_id, is_free: form.is_free, is_published: form.is_published,
      display_order: form.display_order, content: contentObj,
    }

    if (editing) {
      await supabase.from('fiches').update(payload).eq('id', editing.id)
    } else {
      await supabase.from('fiches').insert(payload)
    }

    setSaving(false)
    setModalOpen(false)
    router.refresh()
  }

  async function handleDelete(id: string) {
    const supabase = createClient()
    await supabase.from('fiches').delete().eq('id', id)
    router.refresh()
  }

  return (
    <>
      <AdminTable
        title="Fiches"
        data={fiches}
        columns={[
          { key: 'title', label: 'Titre' },
          { key: 'slug', label: 'Slug' },
          {
            key: 'chapters', label: 'Chapitre',
            render: (f) => f.chapters ? `Ch. ${f.chapters.number}: ${f.chapters.title}` : '—',
          },
          {
            key: 'subjects', label: 'Matière',
            render: (f) => f.chapters?.subjects?.name ?? '—',
          },
          {
            key: 'is_published', label: 'Publié',
            render: (f) => (
              <span className={`inline-block rounded-full px-2 py-0.5 text-xs font-medium ${f.is_published ? 'bg-green-100 text-green-800' : 'bg-gray-100 text-gray-500'}`}>
                {f.is_published ? 'Oui' : 'Non'}
              </span>
            ),
          },
          {
            key: 'is_free', label: 'Gratuit',
            render: (f) => (
              <span className={`inline-block rounded-full px-2 py-0.5 text-xs font-medium ${f.is_free ? 'bg-blue-100 text-blue-800' : 'bg-yellow-100 text-yellow-800'}`}>
                {f.is_free ? 'Gratuit' : 'Premium'}
              </span>
            ),
          },
        ]}
        getId={(f) => f.id}
        onEdit={openEdit}
        onDelete={handleDelete}
        onCreate={openCreate}
        searchField="title"
      />

      <AdminModal
        title={editing ? 'Modifier la fiche' : 'Nouvelle fiche'}
        isOpen={modalOpen}
        onClose={() => setModalOpen(false)}
      >
        <form onSubmit={handleSave} className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-foreground mb-1">Chapitre</label>
            <select value={form.chapter_id} onChange={(e) => setForm({ ...form, chapter_id: e.target.value })} className="w-full rounded-lg border border-gray-200 px-4 py-2.5 text-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:bg-gray-700 dark:border-gray-600">
              {chapters.map((c) => (
                <option key={c.id} value={c.id}>
                  Ch. {c.number}: {c.title} ({c.subjects?.name ?? ''})
                </option>
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
          <div>
            <label className="block text-sm font-medium text-foreground mb-1">Sous-titre</label>
            <input type="text" value={form.subtitle} onChange={(e) => setForm({ ...form, subtitle: e.target.value })} className="w-full rounded-lg border border-gray-200 px-4 py-2.5 text-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:bg-gray-700 dark:border-gray-600" />
          </div>
          <div className="grid grid-cols-3 gap-4">
            <div className="flex items-center gap-2">
              <input type="checkbox" id="is_free" checked={form.is_free} onChange={(e) => setForm({ ...form, is_free: e.target.checked })} className="rounded accent-primary" />
              <label htmlFor="is_free" className="text-sm text-foreground">Gratuit</label>
            </div>
            <div className="flex items-center gap-2">
              <input type="checkbox" id="is_published" checked={form.is_published} onChange={(e) => setForm({ ...form, is_published: e.target.checked })} className="rounded accent-primary" />
              <label htmlFor="is_published" className="text-sm text-foreground">Publié</label>
            </div>
            <div>
              <label className="block text-sm font-medium text-foreground mb-1">Ordre</label>
              <input type="number" value={form.display_order} onChange={(e) => setForm({ ...form, display_order: Number(e.target.value) })} className="w-full rounded-lg border border-gray-200 px-4 py-2.5 text-sm focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:bg-gray-700 dark:border-gray-600" />
            </div>
          </div>
          <div>
            <label className="block text-sm font-medium text-foreground mb-1">
              Contenu (JSON)
            </label>
            <textarea
              value={form.content}
              onChange={(e) => {
                setForm({ ...form, content: e.target.value })
                setJsonError('')
              }}
              rows={12}
              className="w-full rounded-lg border border-gray-200 px-4 py-2.5 text-xs font-mono focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary dark:bg-gray-700 dark:border-gray-600"
              spellCheck={false}
            />
            {jsonError && (
              <p className="mt-1 text-sm text-red-600">{jsonError}</p>
            )}
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
