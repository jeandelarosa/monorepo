import { Router } from 'express';

const router = Router();

router.get('/', (req, res) => {
  res.json({ message: 'Lista de componentes' });
});

router.post('/', (req, res) => {
  res.json({ message: 'Componente creado' });
});

export default router;