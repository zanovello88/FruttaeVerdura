package org.fruttaeverdura.fruttaeverdura.model.mo;

public class Showcase {

    private Long showcase_id;
    private Long id_prod;
    private boolean deleted;

    public Long getShowcaseId() {
        return showcase_id;
    }

    public void setShowcaseId(Long showcase_id) { this.showcase_id = showcase_id; }

    public Long getId_prod() {
        return id_prod;
    }

    public void setId_prod(Long id_prod) { this.id_prod = id_prod; }

    public boolean isDeleted() {
        return deleted;
    }

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
    }
}