{% extends "layout_scs/base.volt" %}
{% block content %}
    <div class="row page-titles">
        <div class="col-md-5 align-self-center">
        <h3 class="text-themecolor">Data Siswa </h3>
        </div>
        <div class="col-md-7 align-self-center">
        <ol class="breadcrumb">
            <li class="breadcrumb-item">
            <a href="javascript:void(0)">Home</a>
            </li>
            <li class="breadcrumb-item active">Data Siswa</li>
        </ol>
        </div>
    </div>
    <div class="container-fluid">
        <!-- Hover Table -->
        <div class="card">
        <div class="card-header">
            <h4 class="card-title m-b-0">Data Siswa</h4>
        </div>
        <div class="card-body">
            <div class="table-responsive">
            <div class="table-wrapper">
                <!-- <div class="headerdata headersisedit">
                <div class="alert alert-warning infonisn">
                    <li>NISN sudah diisi : <b class="hasnisn jaxinfonisn loaddt"></b>
                    </li>
                    <li>NISN belum diisi : <b class="nothasnisn jaxinfonisn loaddt"></b>
                    </li>
                </div>
                </div> -->
                {{ flashSession.output() }}
                <!-- <h5>POST</h5>
                <div><pre><?php print_r($this->request->getPost());?></pre></div>
                <h5>FILES</h5>
                <div><pre><?php print_r($_FILES);?></pre></div>
                <h5>GET</h5>
                <div><pre><?php print_r($this->request->get());?></pre></div>
                <h5>QUERY BIND</h5>
                <div><pre><?php print_r($out->model_siswa);?></pre></div> -->

                <div>
                <?php
                    
                    // echo Config::findFirstByKey('nvr_ip')->value;
                    // echo "asdsad";
                ?>

                </div>

                <form action="/editsiswa" method="get">
                <div class="table-filter">
                    <div class="row">
                    <div class="col-sm-8">
                        <div class="filter-group pull-left m-l-o">
                        <input type="text" name="snamasiswa" class="form-control" value="<?=$this->request->get('snamasiswa')?>" placeholder="Nama Atau NISN">
                        </div>
                        <button type="submit" class="btn btn-primary pull-left">
                        <i class="fa fa-search"></i>
                        </button>
                        <?php
                        if(strlen($this->request->get('snamasiswa')) > 0) {
                            ?>
                            <a class="btn btn-primary pull-left" href="/editsiswa">Reset</a>
                            <?php
                        }
                        ?>
                        <!-- <button type="button" onclick="location.href='https://demo.sekolahan.id/siswaedit/downloadallkartu/?download=1&snamasiswa=a'" class="btn btn-warning pull-left">
                        <i class="fa fa-download"></i> Download Bahan Kartu </button> -->
                    </div>
                    <div class="col-sm-4">
                        <div class="filter-group">
                        <label>Kelas</label>
                        <select class="form-control" style="width: 170px;" name="skelas" onchange="this.form.submit();">
                            <option value="">-- Pilih Kelas --</option>
                            <?php
                            foreach ($out->list_rombel as $v) {
                                $selected=($v['rombel'] == $this->request->get('skelas')) ? 'selected':'';
                                ?>
                                <option <?=$selected?> value="<?=$v['rombel']?>"><?=$v['rombel']?></option>
                                <?php
                            }
                            ?>
                        </select>
                        </div>
                    </div>
                    </div>
                </div>
                </form>
                <table class="table table-striped table-hover">
                <thead>
                    <tr>
                    <th>#</th>
                    <th>Sekolah</th>
                    <th>Foto</th>
                    <th>Nama</th>
                    <th>NISN</th>
                    <th>Kelas</th>
                    <th>No. Kartu</th>
                    <th>Foto</th>
                    <th>Nomor Orangtua</th>
                    <th class="text-center">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <?php
                    $no=1;
                    foreach($data->items as $item) {
                        ?>
                        <tr>
                        <td><?=$no?></td>
                        <td><?=$item->sekolah?></td>
                        <td style="padding-right: 0px; width: 70px;">
                            <a href="/<?=$item->image_path?>" target="_blank">
                            <?php
                            if(strlen($item->image_path) > 0) {
                                ?>
                                <img witdh="80" src="/<?=$item->image_path?>" class="avatar" alt="<?=$item->nama_lengkap?>" style="margin-right: 0px; max-width: 100px;">
                                <?php
                            } else {
                                ?>
                                <img src="/memberdir/82/user.png" class="avatar" alt="Avatar" style="margin-right: 0px; max-width: 100px;">
                                <?php
                            }
                            ?>
                            </a>
                        </td>
                        <td><?=$item->nama_lengkap?></td>
                        <td><?=$item->nisn?></td>
                        <td><?=$item->rombel?></td>
                        <td><?=$item->nik?></td>
                        <td style="width: 180px;">
                            <form action="/editsiswa" method="post" class="siswaftupload" enctype="multipart/form-data">
                            <input type="hidden" name="simpanfoto" value="simpan" />
                            <input type="hidden" class="form-control nisnsiswa" name="nisn" value="<?=$item->nisn?>">
                            <input type="hidden" class="form-control oldfoto" name="oldfoto" value="">
                            <div class="uploadftsiswa">
                                <div class="upload-btn-wrapper">
                                <button type="button" modal-id="captmodal" class="btn btn-default btncaptfoto">
                                    <i class="fa fa-camera"></i>
                                </button>
                                </div>
                                <!-- <span>Atau</span>
                                <div class="upload-btn-wrapper">
                                <button class="btn btn-default">
                                    <i class="fa fa-picture-o"></i>
                                </button>
                                <input id="updfoto" type="file" name="foto" onchange="this.form.submit();" />
                                </div> -->
                            </div>
                            </form>
                        </td>
                        <td><?=$item->nomor_orangtua?></td>
                        <td class="text-center">
                            <a href="/editsiswa/edit/<?=$item->id;?>">
                            <i class="fa fa-edit"></i>
                            </a>
                            </a>
                        </td>
                        </tr>
                        <?php
                        $no ++;
                    }
                    ?>
                </tbody>
                </table>
                <div class="clearfix">
                <div class="hint-text">Showing <b>10</b> out of <b>60</b> entries </div>
                <ul class="pagination">
                    <li class="page-item ">
                    <a href="/editsiswa/index?page=1&skelas=<?=$this->request->get('skelas')?>" class="page-link">First</a>
                    </li>
                    <li class="page-item ">
                    <a href="/editsiswa/index?page=<?= $data->before; ?>&skelas=<?=$this->request->get('skelas')?>" class="page-link">Prev</a>
                    </li>
                    <li class="page-item ">
                    <a href="/editsiswa/index?page=<?= $data->next; ?>&skelas=<?=$this->request->get('skelas')?>" class="page-link">Next</a>
                    </li>
                    <li class="page-item ">
                    <a href="/editsiswa/index?page=<?= $data->last; ?>&skelas=<?=$this->request->get('skelas')?>" class="page-link">Last</a>
                    </li>
                </ul>
                <div class=""><?php echo 'You are in page ', $data->current, ' of ', $data->total_pages; ?></div>
                </div>

                <div class="modal modal-box-2 fade" id="captmodal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content" id="myModalLabel">
                    <form action="#" method="post" class="siswaftupload" enctype="multipart/form-data">
                        <div class="modal-header theme-bg">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">
                        <input type="hidden" name="simpancapture" value="simpan" />
                        <input type="hidden" class="form-control" name="urlprint" value="&snamasiswa=a">
                        <input type="hidden" class="nisnval" name="id" value="">
                        <input type="hidden" class="oldfotoval" name="oldfoto" value="">
                        <input type="hidden" class="captureimage" name="captureimage" value="">
                        <div class="cameraopen">
                            <div class="my_camera"></div>
                        </div>
                        </div>
                        <div class="modal-footer">
                        <div class="btn-modal" id="pre_take_buttons">
                            <button type="button" onClick="preview_snapshot()" class="btn btn-primary">
                            <i class="fa fa-camera"></i> Take Photo </button>
                        </div>
                        <div class="btn-modal" id="post_take_buttons" style="display:none">
                            <button type="button" class="btn btn-warning" onClick="cancel_preview()">
                            <i class="fa fa-undo"></i> Take Photo Again </button>
                            <button type="submit" class="btn btn-success">
                            <i class="fa fa-save"></i> Save Photo </button>
                        </div>
                        </div>
                    </form>
                    </div>
                </div>
                </div>
                <div class="modal modal-box-2 fade" id="modal-import" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <form action="#" method="post" enctype="multipart/form-data">
                    <div class="modal-content" id="myModalLabel">
                        <div class="modal-header theme-bg">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">
                        
                        <input type="file" name="file" id="file" accept=".xls,.xlsx">
                        </div>
                        <div class="modal-footer">
                        <div class="btn-modal">
                            <button type="button" class="btn btn-danger" data-dismiss="modal" aria-hidden="true">Tidak</button>
                            <button type="submit" name="import" value="hapus" class="btn btn-success">Ya</button>
                        </div>
                        </div>
                    </div>
                    </form>
                </div>
                </div>

            </div>
            </div>
            <div class="modal modal-box-2 fade" id="changepass" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content" id="myModalLabel">
                <form action="https://demo.sekolahan.id/siswaedit/changepass/?halaman=1&snamasiswa=a" method="post" class="siswaftupload">
                    <div class="modal-body">
                    <input type="hidden" name="simpanpass" value="simpan" />
                    <input type="hidden" class="emailval" name="id" value="">
                    <input type="hidden" class="dnewpassword" name="dnewpassword" value=""> Anda Yakin akan mengganti password login dari <b>
                        <span id="namachpass"></span>
                        <b>? <br>
                        <div class="passnewinf">
                            <table>
                            <tr>
                                <td>NIS</td>
                                <td>: <span id="nischpass"></span>
                                </td>
                            </tr>
                            <tr>
                                <td>NISN</td>
                                <td>: <span id="nisnchpass"></span>
                                </td>
                            </tr>
                            <tr>
                                <td>Email</td>
                                <td>: <span id="emailchpass"></span>
                                </td>
                            </tr>
                            <tr>
                                <td>Password Baru</td>
                                <td>: <span id="pasnewdt"></span>
                                </td>
                            </tr>
                            </table>
                            <span class="newcustomcb">
                            <input type="checkbox" id="checkboxpass" name="cetakpass" value="1">
                            <label for="checkboxpass">Cetak ?</label>
                            </span>
                        </div>
                    </div>
                    <div class="modal-footer">
                    <div class="btn-modal">
                        <button type="button" class="btn btn-warning" data-dismiss="modal" aria-hidden="true">
                        <i class="fa fa-reply"></i> Batalkan </button>
                        <button type="submit" class="btn btn-success">
                        <i class="fa fa-save"></i> Ubah Password </button>
                    </div>
                    </div>
                </form>
                </div>
            </div>
            </div>
        </div>
        </div>
        <!-- ./Hover Table -->
    </div>
{% endblock %}