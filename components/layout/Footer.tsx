import Link from 'next/link'
import { GraduationCap } from 'lucide-react'

const footerLinks = {
  produit: [
    { href: '#comment-ca-marche', label: 'Comment ça marche' },
    { href: '#tarifs', label: 'Tarifs' },
    { href: '/signup', label: 'Créer un compte' },
  ],
  ressources: [
    { href: '/mali', label: 'Réviser (Mali)' },
    { href: '/a-propos', label: 'À propos' },
  ],
  legal: [
    { href: '/conditions', label: 'Conditions d\'utilisation' },
    { href: '/confidentialite', label: 'Politique de confidentialité' },
  ],
}

export default function Footer() {
  return (
    <footer className="bg-gray-900 dark:bg-[#0a0f14] text-gray-400">
      <div className="mx-auto max-w-7xl px-4 py-16 sm:px-6 lg:px-8">
        <div className="grid grid-cols-2 md:grid-cols-4 gap-8">
          {/* Brand Column */}
          <div className="col-span-2 md:col-span-1">
            <Link href="/" className="flex items-center gap-2 mb-4">
              <div className="w-9 h-9 rounded-xl bg-primary flex items-center justify-center">
                <GraduationCap className="h-5 w-5 text-white" />
              </div>
              <span className="font-serif text-lg font-bold text-white">
                BacSuccess
              </span>
            </Link>
            <p className="text-sm leading-relaxed">
              Plateforme de révision pour le baccalauréat africain. Fiches, quiz et exercices pour réussir.
            </p>
          </div>

          {/* Produit */}
          <div>
            <h4 className="font-serif font-bold text-white text-sm mb-4">Produit</h4>
            <ul className="space-y-2">
              {footerLinks.produit.map((link) => (
                <li key={link.label}>
                  <Link href={link.href} className="text-sm hover:text-white transition-colors">
                    {link.label}
                  </Link>
                </li>
              ))}
            </ul>
          </div>

          {/* Ressources */}
          <div>
            <h4 className="font-serif font-bold text-white text-sm mb-4">Ressources</h4>
            <ul className="space-y-2">
              {footerLinks.ressources.map((link) => (
                <li key={link.label}>
                  <Link href={link.href} className="text-sm hover:text-white transition-colors">
                    {link.label}
                  </Link>
                </li>
              ))}
            </ul>
          </div>

          {/* Légal */}
          <div>
            <h4 className="font-serif font-bold text-white text-sm mb-4">Légal</h4>
            <ul className="space-y-2">
              {footerLinks.legal.map((link) => (
                <li key={link.label}>
                  <Link href={link.href} className="text-sm hover:text-white transition-colors">
                    {link.label}
                  </Link>
                </li>
              ))}
            </ul>
          </div>
        </div>

        {/* Payment Methods + Copyright */}
        <div className="mt-12 pt-8 border-t border-gray-800">
          <div className="flex flex-col sm:flex-row items-center justify-between gap-4">
            <div className="flex flex-wrap items-center gap-2">
              <span className="text-xs text-gray-500 mr-2">Paiement par</span>
              <span className="rounded-full bg-orange-600/20 text-orange-400 px-2.5 py-0.5 text-[10px] font-bold">Orange Money</span>
              <span className="rounded-full bg-blue-600/20 text-blue-400 px-2.5 py-0.5 text-[10px] font-bold">Wave</span>
              <span className="rounded-full bg-yellow-600/20 text-yellow-400 px-2.5 py-0.5 text-[10px] font-bold">MTN</span>
              <span className="rounded-full bg-indigo-600/20 text-indigo-400 px-2.5 py-0.5 text-[10px] font-bold">Visa</span>
            </div>
            <p className="text-xs text-gray-500">
              &copy; {new Date().getFullYear()} BacSuccess. Tous droits réservés.
            </p>
          </div>
        </div>
      </div>
    </footer>
  )
}
