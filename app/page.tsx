import type { Metadata } from 'next'
import Header from '@/components/layout/AuthHeader'
import Footer from '@/components/layout/Footer'
import HeroSection from '@/components/landing/HeroSection'
import FeaturesGrid from '@/components/landing/FeaturesGrid'
import HowItWorks from '@/components/landing/HowItWorks'
import SocialProof from '@/components/landing/SocialProof'
import PricingGrid from '@/components/landing/PricingGrid'
import FAQ from '@/components/landing/FAQ'
import FinalCTA from '@/components/landing/FinalCTA'

export const metadata: Metadata = {
  title: 'BacSuccess - Réussis ton Bac. Point final.',
  description:
    'Plateforme gratuite de révision pour le baccalauréat africain. Fiches de révision, quiz interactifs et schémas pour réussir ton Bac au Mali, Sénégal et plus.',
}

export default function HomePage() {
  return (
    <div className="flex min-h-screen flex-col bg-background">
      <Header />
      <main className="flex-1">
        <HeroSection />
        <FeaturesGrid />
        <HowItWorks />
        <SocialProof />
        <PricingGrid />
        <FAQ />
        <FinalCTA />
      </main>
      <Footer />
    </div>
  )
}
