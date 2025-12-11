<?php
use Phalcon\Mvc\User\Component;
use Phalcon\Mvc\Model;

class AlsusInventory extends Component
{
    public function updateAlsusPositionDipinjam($id_alsus)
    {
        // update alsus item to DIPINJAM
        $this->db->query("UPDATE alsus SET position='DIPINJAM' WHERE id=$id_alsus");
    }

    public function updateAlsusPositionDikembalikan($id_alsus)
    {
        // update alsus item to DIPINJAM
        $this->db->query("UPDATE alsus SET position='AVAILABLE' WHERE id=$id_alsus");
    }

    public function updateAlsusProductQuantity($id_alsus)
    {
        // update quantity dipinjam
        $alsus=$this->db->fetchOne("SELECT * FROM alsus WHERE id=$id_alsus",\Phalcon\Db::FETCH_OBJ);
        $product=$this->db->fetchOne("SELECT * FROM alsus_product WHERE id=$alsus->id_product",\Phalcon\Db::FETCH_OBJ);

        $dipinjam=$this->db->fetchOne("
            SELECT COUNT(1) AS total 
            FROM alsus 
            WHERE id_product=$alsus->id_product AND position='DIPINJAM'
        ", \Phalcon\Db::FETCH_OBJ);

        $updateAlsusProduct=$this->db->query("
            UPDATE alsus_product 
            SET 
            quantity=$product->quantity, 
            quantity_dipinjam=$dipinjam->total,
            quantity_available=".($product->quantity-$dipinjam->total)." 
            WHERE id=$alsus->id_product");
    }
}