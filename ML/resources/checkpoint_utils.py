import torch
import os

def save_checkpoint(model, optimizer, epoch, loss, checkpoint_dir):
    checkpoint = {
        'model_state_dict': model.state_dict(),
        'optimizer_state_dict': optimizer.state_dict(),
        'epoch': epoch,
        'loss': loss
    }
    checkpoint_path = os.path.join(checkpoint_dir, f'checkpoint_epoch_{epoch}.pt')
    torch.save(checkpoint, checkpoint_path)
    print(f'Checkpoint saved at {checkpoint_path}')

def load_checkpoint(model, optimizer, checkpoint_path):
    # Load the checkpoint
    checkpoint = torch.load(checkpoint_path)

    # Restore the model and optimizer states
    model.load_state_dict(checkpoint['model_state_dict'])
    optimizer.load_state_dict(checkpoint['optimizer_state_dict'])

    # Retrieve other training parameters
    epoch = checkpoint['epoch']
    loss = checkpoint['loss']
    print(f'Checkpoint loaded from {checkpoint_path}, resuming from epoch {epoch + 1}')

    return model, optimizer, epoch, loss
