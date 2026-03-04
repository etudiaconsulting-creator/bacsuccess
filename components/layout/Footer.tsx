import { GraduationCap } from "lucide-react";

export default function Footer() {
  return (
    <footer className="bg-primary">
      <div className="mx-auto max-w-7xl px-4 py-8 sm:px-6 lg:px-8">
        <div className="flex flex-col items-center gap-3 text-center">
          <div className="flex items-center gap-2">
            <GraduationCap className="h-6 w-6 text-secondary" />
            <span className="font-serif text-lg font-bold text-white">
              BacSuccess
            </span>
          </div>
          <p className="max-w-md text-sm text-gray-300">
            Plateforme de révision pour le baccalauréat africain
          </p>
          <div className="mt-2 text-xs text-gray-400">
            &copy; 2024 BacSuccess. Tous droits réservés.
          </div>
        </div>
      </div>
    </footer>
  );
}
