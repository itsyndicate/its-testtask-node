resource "aws_efs_file_system" "EFS" {
    creation_token = "my-product"
    performance_mode = var.efs_performance_mode
    throughput_mode = var.efs_throughput_mode  

#    lifecycle_policy{
#        transition_to_ia = "AFTER_30_DAYS"
#    }

    tags = {
        Name = var.efs_name
    }
}

resource "aws_efs_mount_target" "efs-target1" {
    subnet_id = module.task-vpc.public_subnets[0]
    file_system_id = aws_efs_file_system.EFS.id
    security_groups = [module.eks.cluster_security_group_id]
}

resource "aws_efs_mount_target" "efs-target2" {
    subnet_id = module.task-vpc.public_subnets[1]
    file_system_id = aws_efs_file_system.EFS.id
    security_groups = [module.eks.cluster_security_group_id]
}

resource "kubernetes_csi_driver_v1" "efs" {
    metadata {
        name = "efs.csi.aws.com"
    }
    spec {
        attach_required = false
        volume_lifecycle_modes = ["Persistent"]
    }
}

resource "kubernetes_storage_class" "efs" {
    metadata {
        name = "efs-sc"
    }
    storage_provisioner = kubernetes_csi_driver_v1.efs.metadata[0].name
    reclaim_policy = "Retain"
}

resource "kubernetes_persistent_volume" "efs_data" {
    metadata {
        name = "pv-efsdata"

        labels = {
            app = "task-pv"
        }
    }

    spec {
        access_modes = ["ReadWriteMany"]

        capacity = {
            storage = "1Gi"
        }

        volume_mode = "Filesystem"
        persistent_volume_reclaim_policy = "Retain"
        storage_class_name = kubernetes_storage_class.efs.metadata[0].name

        persistent_volume_source {
            csi {
                driver = kubernetes_csi_driver_v1.efs.metadata[0].name
                volume_handle = aws_efs_file_system.EFS.id
                read_only = false
            }
        }
    }
}