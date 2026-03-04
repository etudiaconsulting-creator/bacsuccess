import Link from "next/link";
import { ChevronRight } from "lucide-react";

interface BreadcrumbItem {
  label: string;
  href?: string;
}

interface BreadcrumbProps {
  items: BreadcrumbItem[];
}

export default function Breadcrumb({ items }: BreadcrumbProps) {
  return (
    <nav aria-label="Breadcrumb" className="py-3">
      <ol className="flex flex-wrap items-center gap-1 text-sm">
        <li>
          <Link
            href="/"
            className="text-muted transition-colors hover:text-primary"
          >
            Accueil
          </Link>
        </li>
        {items.map((item, index) => {
          const isLast = index === items.length - 1;

          return (
            <li key={index} className="flex items-center gap-1">
              <ChevronRight className="h-4 w-4 text-muted" />
              {isLast || !item.href ? (
                <span className="font-semibold text-foreground">
                  {item.label}
                </span>
              ) : (
                <Link
                  href={item.href}
                  className="text-muted transition-colors hover:text-primary"
                >
                  {item.label}
                </Link>
              )}
            </li>
          );
        })}
      </ol>
    </nav>
  );
}
