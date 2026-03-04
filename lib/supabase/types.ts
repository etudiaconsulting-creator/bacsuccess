export interface Flashcard {
  id: string
  category: string
  question: string
  answer: string
}

export interface SchemaNode {
  id: string
  label: string
  x?: number
  y?: number
  type: 'main' | 'branch' | 'leaf'
}

export interface SchemaEdge {
  from: string
  to: string
  label?: string
}

export interface SchemaContent {
  title: string
  nodes: SchemaNode[]
  edges: SchemaEdge[]
}

export interface QuizQuestion {
  id: string
  question: string
  options: string[]
  correct: number
  explanation: string
}

export interface FicheContent {
  flashcards: Flashcard[]
  schema: SchemaContent
  quiz: QuizQuestion[]
}

export interface Country {
  id: string
  slug: string
  name: string
  flag_emoji: string | null
  is_active: boolean
  created_at: string
}

export interface Series {
  id: string
  country_id: string
  slug: string
  name: string
  short_name: string
  description: string | null
  is_active: boolean
  created_at: string
}

export interface Subject {
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
}

export interface Chapter {
  id: string
  subject_id: string
  slug: string
  number: number
  title: string
  description: string | null
  display_order: number
  created_at: string
}

export interface Fiche {
  id: string
  chapter_id: string
  slug: string
  title: string
  subtitle: string | null
  content: FicheContent
  is_free: boolean
  is_published: boolean
  display_order: number
  created_at: string
  updated_at: string
}

export interface UserProgress {
  id: string
  user_id: string
  fiche_id: string
  viewed: boolean
  viewed_at: string | null
  quiz_score: number | null
  quiz_taken_at: string | null
  created_at: string
  updated_at: string
}

export interface Database {
  public: {
    Tables: {
      countries: {
        Row: Country
        Insert: Omit<Country, 'id' | 'created_at'> & { id?: string; created_at?: string }
        Update: Partial<Omit<Country, 'id'>>
      }
      series: {
        Row: Series
        Insert: Omit<Series, 'id' | 'created_at'> & { id?: string; created_at?: string }
        Update: Partial<Omit<Series, 'id'>>
      }
      subjects: {
        Row: Subject
        Insert: Omit<Subject, 'id' | 'created_at'> & { id?: string; created_at?: string }
        Update: Partial<Omit<Subject, 'id'>>
      }
      chapters: {
        Row: Chapter
        Insert: Omit<Chapter, 'id' | 'created_at'> & { id?: string; created_at?: string }
        Update: Partial<Omit<Chapter, 'id'>>
      }
      fiches: {
        Row: Fiche
        Insert: Omit<Fiche, 'id' | 'created_at' | 'updated_at'> & { id?: string; created_at?: string; updated_at?: string }
        Update: Partial<Omit<Fiche, 'id'>>
      }
      user_progress: {
        Row: UserProgress
        Insert: Omit<UserProgress, 'id' | 'created_at' | 'updated_at'> & { id?: string; created_at?: string; updated_at?: string }
        Update: Partial<Omit<UserProgress, 'id'>>
      }
    }
  }
}
