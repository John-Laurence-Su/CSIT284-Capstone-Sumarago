import '../models/book.dart';
import '../models/loan.dart';

const List<Book> sampleBooks = [
  Book(
    id: 'BK-001',
    title: 'Noli Me Tangere',
    author: 'José Rizal',
    genre: 'Classic',
    year: 1887,
    isbn: '9780143039693',
    description: 'A novel exposing the abuses of Spanish colonial rule in the Philippines.',
  ),
  Book(
    id: 'BK-002',
    title: 'El Filibusterismo',
    author: 'José Rizal',
    genre: 'Classic',
    year: 1891,
    isbn: '9780824824501',
    description: 'The sequel to Noli Me Tangere, darker and more political.',
  ),
  Book(
    id: 'BK-003',
    title: 'Clean Code',
    author: 'Robert C. Martin',
    genre: 'Technology',
    year: 2008,
    isbn: '9780132350884',
    description: 'A handbook of agile software craftsmanship.',
  ),
  Book(
    id: 'BK-004',
    title: 'The Pragmatic Programmer',
    author: 'Andrew Hunt, David Thomas',
    genre: 'Technology',
    year: 1999,
    isbn: '9780201616224',
    description: 'Practical advice for becoming a better developer.',
  ),
  Book(
    id: 'BK-005',
    title: 'Atomic Habits',
    author: 'James Clear',
    genre: 'Self-help',
    year: 2018,
    isbn: '9780735211292',
    description: 'Small changes that lead to remarkable results.',
  ),
  Book(
    id: 'BK-006',
    title: 'Sapiens',
    author: 'Yuval Noah Harari',
    genre: 'History',
    year: 2011,
    isbn: '9780062316097',
    description: 'A brief history of humankind.',
  ),
  Book(
    id: 'BK-007',
    title: 'Dune',
    author: 'Frank Herbert',
    genre: 'Sci-Fi',
    year: 1965,
    isbn: '9780441172719',
    description: 'Politics, religion and ecology on the desert planet Arrakis.',
  ),
  Book(
    id: 'BK-008',
    title: 'The Hobbit',
    author: 'J.R.R. Tolkien',
    genre: 'Fantasy',
    year: 1937,
    isbn: '9780547928227',
    description: 'Bilbo Baggins joins a company of dwarves on a quest for treasure.',
  ),
  Book(
    id: 'BK-009',
    title: 'To Kill a Mockingbird',
    author: 'Harper Lee',
    genre: 'Classic',
    year: 1960,
    isbn: '9780061120084',
    description: 'A young girl watches her father defend a Black man in the Deep South.',
  ),
  Book(
    id: 'BK-010',
    title: 'The Alchemist',
    author: 'Paulo Coelho',
    genre: 'Fiction',
    year: 1988,
    isbn: '9780062315007',
    description: 'A shepherd boy travels in search of his personal legend.',
  ),
  Book(
    id: 'BK-011',
    title: 'Educated',
    author: 'Tara Westover',
    genre: 'Memoir',
    year: 2018,
    isbn: '9780399590504',
    description: 'A memoir of growing up in a survivalist family and finding education.',
  ),
  Book(
    id: 'BK-012',
    title: 'Thinking, Fast and Slow',
    author: 'Daniel Kahneman',
    genre: 'Psychology',
    year: 2011,
    isbn: '9780374533557',
    description: 'How two systems of thought shape our judgments and decisions.',
  ),

  Book(
    id: 'BK-013', 
    title: 'The Power of Habit', 
    author: 'Charles Duhigg', 
    genre: 'Self-help', 
    year: 2012, 
    isbn: '9780812981605',
    description: 'Why we do what we do in life and business.'
    ),

  Book(
    id: 'BK-014',
    title: 'The Little Prince',
    author: 'Antoine de Saint-Exupéry',
    genre: 'Fiction',
    year: 1943,
    isbn: '9780156012195',
    description: 'A young prince explores the universe and learns about love and loss.'
  ),

  Book(
    id: 'BK-015',
    title: '1984',
    author: 'George Orwell',
    genre: 'Dystopian',
    year: 1949,
    isbn: '9780451524935',
    description: 'A novel about totalitarianism and surveillance.'
    ),

    Book(
      id: 'BK-016',
      title: 'The Catcher in the Rye',
      author: 'J.D. Salinger',
      genre: 'Fiction',
      year: 1951,
      isbn: '9780316769488',
      description: 'A story about teenage alienation and loss.'
    ),

    Book(
      id: 'BK-017',
      title: 'Pride and Prejudice',
      author: 'Jane Austen',
      genre: 'Classic',
      year: 1813,
      isbn: '9780141439518',
      description: 'A romantic novel that critiques the British landed gentry at the end of the 18th century.'
    ),

    Book(
      id: 'BK-018',
      title: 'The Great Gatsby',
      author: 'F. Scott Fitzgerald',
      genre: 'Classic',
      year: 1925,
      isbn: '9780743273565',
      description: 'A novel about the American dream and the disillusionment of the Jazz Age.'
    ),

    Book(
      id: 'BK-019',
      title: 'Moby-Dick',
      author: 'Herman Melville',
      genre: 'Classic',
      year: 1851,
      isbn: '9781503280786',
      description: 'A novel about the voyage of the whaling ship Pequod.'
    ),

    Book(
      id: 'BK-020',
      title: 'Divine Comedy',
      author: 'Dante Alighieri',
      genre: 'Epic Poetry',
      year: 1320,
      isbn: '9780143105032',
      description: 'A narrative poem that describes Dante\'s journey through the afterlife.'
    ),

    Book(
      id: 'BK-021',
      title: 'The Odyssey',
      author: 'Homer',
      genre: 'Epic Poetry',
      year: 800 ,
      isbn: '9780140268867',
      description: 'An epic poem that follows the hero Odysseus on his journey home from the Trojan War.'
    ),

    Book(
      id: 'BK-022',
      title: 'Omniscient Reader\'s Viewpoint',
      author: 'Sing Shong',
      genre: 'Web Novel',
      year: 2020,
      isbn: '9780140275360',
      description: 'A web novel that follows the story of a man who becomes the protagonist of a novel he has been reading.'
    ),

    Book(
      id: 'BK-023',
      title: 'The Artist who paints dungeons',
      author: 'Hobby Writing Principle',
      genre: 'Web Novel',
      year: 2024,
      isbn: '9780143039053',
      description: 'A web novel that follows the story of an artist who paints dungeons and becomes trapped in one.'
    ),

    Book(
      id: 'BK-024',
      title: 'The Beginning After the End',
      author: 'TurtleMe',
      genre: 'Web Novel',
      year: 2017,
      isbn: '9780143039053',
      description: 'A web novel that follows the story of a king who is reincarnated in a magical world.'
    ),

    Book(
      id: 'BK-025',
      title: 'Solo Leveling',
      author: 'Chugong',
      genre: 'Web Novel',
      year: 2018,
      isbn: '9780143039053',
      description: 'A web novel that follows the story of a weak hunter who becomes the strongest after a mysterious event.'
    ),

    Book(
      id: 'BK-026',
      title: 'The Legendary Moonlight Sculptor',
      author: 'Nam Heesung',
      genre: 'Web Novel',
      year: 2018,
      isbn: '9780143039053',
      description: 'A web novel that follows the story of a sculptor who becomes a legendary figure in a virtual world.'
    ),

    Book(
      id: 'BK-027',
      title: 'Ode of the Brave',
      author: 'Dodongpa',
      genre: 'Web Novel',
      year: 2024,
      isbn: '9780143039053',
      description: 'A web novel that follows the story of a brave warrior who fights against evil forces in a fantasy world.'
    ),

];

/// A few demo loans so the Loans tab is not empty on first launch.
List<Loan> buildSampleLoans() {
  final now = DateTime.now();
  return [
    Loan(
      id: 'LN-0001',
      bookId: 'BK-003',
      memberId: 'M-1001',
      borrowedAt: now.subtract(const Duration(days: 5)),
      dueAt: now.add(const Duration(days: 9)),
    ),
    Loan(
      id: 'LN-0002',
      bookId: 'BK-007',
      memberId: 'M-1002',
      borrowedAt: now.subtract(const Duration(days: 20)),
      dueAt: now.subtract(const Duration(days: 6)),
    ),
    Loan(
      id: 'LN-0003',
      bookId: 'BK-005',
      memberId: 'M-1001',
      borrowedAt: now.subtract(const Duration(days: 30)),
      dueAt: now.subtract(const Duration(days: 16)),
      returnedAt: now.subtract(const Duration(days: 18)),
    ),
  ];
}
